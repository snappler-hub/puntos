namespace :get_db_files do
  desc 'Obtiene de la API REST los zip de la base de datos'

  task :execute => :environment do
    
    if UpdateLog.last.nil?
      id = '14000'
    else
      id = UpdateLog.last.identifier.to_s
    end

    while true
      response_me = RestClient.get "http://web.alfabeta.net/update?usr=alejandra&pw=ale372&src=ME&id=#{id}"
      response_md = RestClient.get "http://web.alfabeta.net/update?usr=alejandra&pw=ale372&src=MD&id=#{id}"

      break if response_md.code == 204

      filename_me = response_me.headers[:content_disposition].split('=').last
      filename_md = response_md.headers[:content_disposition].split('=').last
      zip_file_path_me = File.join(Rails.root, 'lib', 'data', filename_me)
      zip_file_path_md = File.join(Rails.root, 'lib', 'data', filename_md)
      unzip_file_path = File.join(Rails.root, 'lib', 'data', filename_md[0..filename_md.size-10]) # Es indistinto que filename use

      File.open(zip_file_path_me, 'wb') do |file|
        RestClient.get "http://web.alfabeta.net/update?usr=alejandra&pw=ale372&src=ME&id=#{id}" do |binary_response|
          file.write binary_response
        end
      end

      Zip::File.open(zip_file_path_me) do |zip_file|
        entry = zip_file.glob('monodro.txt').first
        FileUtils::mkdir_p(unzip_file_path)
        zip_file.extract(entry, "#{unzip_file_path}/#{entry.name}")
        entry = zip_file.glob('manextra.txt').first
        zip_file.extract(entry, "#{unzip_file_path}/#{entry.name}")
      end

      File.open(zip_file_path_md, 'wb') do |file|
        RestClient.get "http://web.alfabeta.net/update?usr=alejandra&pw=ale372&src=MD&id=#{id}" do |binary_response|
          file.write binary_response
        end
      end
      Zip::File.open("./lib/data/#{filename_md}") do |zip_file|
        entry = zip_file.glob('manual.dat').first
        FileUtils::mkdir_p(unzip_file_path)
        zip_file.extract(entry, "#{unzip_file_path}/#{entry.name}")
      end
  
      reporte = {drug: [], product: []}
	    products = []
      drugs = []
      prices = []
      
      filename = "#{unzip_file_path}/monodro.txt"
      File.open(filename, 'r:CP850:utf-8') do |file|
        file.each_line do |line|
          drug = Drug.find_by name: "#{line[5, 32].squeeze(' ').strip}"
          drug_hash = {description: "Drug id: #{line[0, 5]}"}
          file_drug = Drug.new
          file_drug.id = line[0, 5]
          file_drug.name = "#{line[5, 32].squeeze(' ').strip}"
          if drug.nil?
            reporte[:drug] << drug_hash.merge({action: 'Create'})
            
            # Drug.create(
            #     id: line[0, 5],
            #     name: "#{line[5, 32].squeeze(' ').strip}"
            # )
          else
            reporte[:drug] << drug_hash.merge({action: 'Update'})
            # drug.update(
            #     id: line[0, 5],
            #     name: "#{line[5, 32].squeeze(' ').strip}"
            # )
            # drug.save
          end
          drugs << file_drug
        end
        Drug.import drugs, :on_duplicate_key_update => [:name]
        puts "terminaron las drogas"
      end



      filename = "#{unzip_file_path}/manual.dat"
      File.open(filename, 'r:CP850:utf-8') do |file|
        file.each_line do |line|
          product = Product.find_by alfabeta_identifier: line[126, 5]

         	product_hash = {description: "Product alfabeta_identifier: #{line[126, 5]}"}
          
          # file_product = Product.new
          # file_product.troquel_number = line[0, 7]
          # file_product.name = "#{line[7, 44].squeeze(' ').strip}"
          # file_product.presentation_form = "#{line[51, 24].squeeze(' ').strip}"
          # file_product.full_name = "#{line[7, 44].squeeze(' ').strip}, #{line[51, 24].squeeze(' ').strip}"
          # file_product.laboratory = Laboratory.where(name: "#{line[85, 16].squeeze(' ').strip}").first_or_create
          # file_product.price_in_cents = line[101, 9]
          # file_product.alfabeta_identifier = line[126, 5]
          # file_product.barcode = line[132, 13]
          # file_product.drug_id = 0

          if product.nil?
            reporte[:product] << product_hash.merge({action: 'Create'})
            # Product.create(
            #     troquel_number: line[0, 7],
            #     name: "#{line[7, 44].squeeze(' ').strip}",
            #     presentation_form: "#{line[51, 24].squeeze(' ').strip}",
            #     full_name: "#{line[7, 44].squeeze(' ').strip}, #{line[51, 24].squeeze(' ').strip}",
            #     laboratory: Laboratory.where(name: "#{line[85, 16].squeeze(' ').strip}").first_or_create,
            #     price_in_cents: line[101, 9],
            #     alfabeta_identifier: line[126, 5],
            #     barcode: line[132, 13]
            # )
          else
            #PriceHistory.create(product_id: product.id, price: product.price, identifier: id.to_i)
            # price = PriceHistory.new
            # price.product_id = product.id
            # price.price = product.price
            # price.identifier = id.to_i
            # prices << price
            reporte[:product] << product_hash.merge({action: 'Update'})
            
            # product.update(
            #     troquel_number: line[0, 7],
            #     name: "#{line[7, 44].squeeze(' ').strip}",
            #     presentation_form: "#{line[51, 24].squeeze(' ').strip}",
            #     full_name: "#{line[7, 44].squeeze(' ').strip}, #{line[51, 24].squeeze(' ').strip}",
            #     laboratory: Laboratory.where(name: "#{line[85, 16].squeeze(' ').strip}").first_or_create,
            #     price_in_cents: line[101, 9],
            #     alfabeta_identifier: line[126, 5],
            #     barcode: line[132, 13]
            # )
            # product.save
          end
        	products << [line[132, 13],line[0, 7],"#{line[7, 44].squeeze(' ').strip}","#{line[7, 44].squeeze(' ').strip}, #{line[51, 24].squeeze(' ').strip}",line[101, 9],"#{line[51, 24].squeeze(' ').strip}",line[126, 5],Laboratory.where(name: "#{line[85, 16].squeeze(' ').strip}").first_or_create]  
        end
        p "productos creados y cargados al array"
        #binding.pry
        Product.import [:barcode,:troquel_number,:name,:full_name,:price_in_cents,:presentation_form,:alfabeta_identifier,:laboratory_id], products
        #Product.import products, :on_duplicate_key_update => [:barcode,:troquel_number,:name,:full_name,:price_in_cents,:presentation_form,:alfabeta_identifier,:laboratory_id]
        p "productos en la db"
        PriceHistory.import prices
        p "hitorial de precios en la db"
      end


      filename = "#{unzip_file_path}/manextra.txt"
      File.open(filename, 'r:CP850:utf-8') do |file|
        file.each_line do |line|
          p = Product.where(alfabeta_identifier: line[0, 5]).take
          unless p.nil?
            p.update_column(:drug_id, line[12, 5])
            p.save
          end
        end
      end

      UpdateLog.create(description: reporte, identifier: id.to_i)
      id = response_me.headers[:numero]
    end

  end
end