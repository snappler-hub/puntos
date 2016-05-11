namespace :get_db_files do
	desc "Obtiene de la API REST los zip de la base de datos"
	task :execute => :environment do 
		reporte = {drug: [], product: []}
		if UpdateLog.last.nil?
			id = "14000"
		else
			id = UpdateLog.last.identifier.to_s
		end
		
		while true
			response_ME = RestClient.get "http://web.alfabeta.net/update?usr=alejandra&pw=ale372&src=ME&id=#{id}"
			response_MD = RestClient.get "http://web.alfabeta.net/update?usr=alejandra&pw=ale372&src=MD&id=#{id}"
			
			if response_MD.code == 204
				break
			end
			
			filename_ME = response_ME.headers[:content_disposition].split("=").last
			filename_MD = response_MD.headers[:content_disposition].split("=").last
			zip_file_path_ME = File.join(Rails.root, 'lib', 'data', filename_ME)
			zip_file_path_MD = File.join(Rails.root, 'lib', 'data', filename_MD)
			unzip_file_path = File.join(Rails.root, 'lib', 'data', filename_MD[0..filename_MD.size-10]) #Es indistinto que filename use
			
			#unless id == "14000"
				File.open(zip_file_path_ME,'wb') do |file|
				  RestClient.get "http://web.alfabeta.net/update?usr=alejandra&pw=ale372&src=ME&id=#{id}" do |binary_response|
				  	file.write binary_response
				 	end 
				end			
				Zip::File.open(zip_file_path_ME) do |zip_file|
	    		entry = zip_file.glob('monodro.txt').first
		      FileUtils::mkdir_p(unzip_file_path)
		      zip_file.extract(entry, unzip_file_path+"/"+entry.name)
		      entry = zip_file.glob('manextra.txt').first
		      zip_file.extract(entry, unzip_file_path+"/"+entry.name)
				end
				File.open(zip_file_path_MD,'wb') do |file|
				  RestClient.get "http://web.alfabeta.net/update?usr=alejandra&pw=ale372&src=MD&id=#{id}" do |binary_response|
				  	file.write binary_response
				 	end 
				end
				Zip::File.open("./lib/data/"+filename_MD) do |zip_file|
	    		entry = zip_file.glob('manual.dat').first
		      FileUtils::mkdir_p(unzip_file_path)
		      zip_file.extract(entry, unzip_file_path+"/"+entry.name) 
				end
			#end

			filename = unzip_file_path + "/monodro.txt"
			File.open(filename, 'r:CP850:utf-8') do |file|
	      file.each_line do |line|
	        drug = Drug.find_by name: "#{line[5, 32].squeeze(' ').strip}"
	        drug_hash = {
	        	id: line[0, 5],
	          name: "#{line[5, 32].squeeze(' ').strip}"
	         }
	        unless drug.nil?
	        	reporte[:drug] << drug_hash.merge({action: "Update"})
	        	drug.update(
	            id: line[0, 5],
	            name: "#{line[5, 32].squeeze(' ').strip}"
	        	)
	        	drug.save
	        else
	        	reporte[:drug] << drug_hash.merge({action: "Create"})
	        	Drug.create(
	            id: line[0, 5],
	            name: "#{line[5, 32].squeeze(' ').strip}"
	        	)
	        end
	        p "Drug #{line[0, 5]}"
	      end
	    end
			
			filename = unzip_file_path + "/manual.dat"
	    File.open(filename, 'r:CP850:utf-8') do |file|
	      file.each_line do |line|
	      	product = Product.find_by alfabeta_identifier: line[126, 5]
	      	product_hash = {
	      		troquel_number: line[0, 7],
            name: "#{line[7, 44].squeeze(' ').strip}",
            presentation_form: "#{line[51, 24].squeeze(' ').strip}",
            full_name: "#{line[7, 44].squeeze(' ').strip}, #{line[51, 24].squeeze(' ').strip}",
            laboratory: Laboratory.where(name: "#{line[85, 16].squeeze(' ').strip}").first_or_create,
            price_in_cents: line[101, 9],
            alfabeta_identifier: line[126, 5],
            barcode: line[132, 13]
	      	}
	      	unless product.nil?
	      		PriceHistory.create(product_id: product.id, price: product.price, identifier: id.to_i)
	      		reporte[:product] << product_hash.merge({action: "Update"})
	      		product.update(
	            troquel_number: line[0, 7],
	            name: "#{line[7, 44].squeeze(' ').strip}",
	            presentation_form: "#{line[51, 24].squeeze(' ').strip}",
	            full_name: "#{line[7, 44].squeeze(' ').strip}, #{line[51, 24].squeeze(' ').strip}",
	            laboratory: Laboratory.where(name: "#{line[85, 16].squeeze(' ').strip}").first_or_create,
	            price_in_cents: line[101, 9],
	            alfabeta_identifier: line[126, 5],
	            barcode: line[132, 13]
	        	)
	        	product.save	
	      	else
	      		reporte[:product] << product_hash.merge({action: "Create"})
		        Product.create(
		            troquel_number: line[0, 7],
		            name: "#{line[7, 44].squeeze(' ').strip}",
		            presentation_form: "#{line[51, 24].squeeze(' ').strip}",
		            full_name: "#{line[7, 44].squeeze(' ').strip}, #{line[51, 24].squeeze(' ').strip}",
		            laboratory: Laboratory.where(name: "#{line[85, 16].squeeze(' ').strip}").first_or_create,
		            price_in_cents: line[101, 9],
		            alfabeta_identifier: line[126, 5],
		            barcode: line[132, 13]
		        )
		      end
		      p "Product #{line[126, 5]}"
	      end
	    end


			filename = unzip_file_path + "/manextra.txt"
	    File.open(filename, 'r:CP850:utf-8') do |file|
	      file.each_line do |line|
	        p = Product.where(alfabeta_identifier: line[0, 5]).take
	        unless p.nil?
	          p.update_column(:drug_id, line[12, 5])
	          p.save
	        end
	        puts "Associate #{line[12, 5]}"
	      end
	    end

	    UpdateLog.create(description: reporte, identifier: id.to_i)
			id = response_ME.headers[:numero]
		end
	
	end
end