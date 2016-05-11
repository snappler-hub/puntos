namespace :update_products do
	desc "Actualización de los precios de los productos"
	task :execute => :environment do 

		reporte = ""
		
	#   filename = Rails.root.join('lib', 'data', 'MONODRO.TXT')

		# File.open(filename, 'r:CP850:utf-8') do |file|
		#       file.each_line do |line|
		#         drug = Drug.find_by name: "#{line[5, 32].squeeze(' ').strip}"
		#         unless drug.nil?
		#         	reporte = reporte + "Update drug;"
		#         	drug.update(
		#             id: line[0, 5],
		#             name: "#{line[5, 32].squeeze(' ').strip}",
		#         	)
		#         	drug.save
		#         else
		#         	reporte = reporte + "Create drug;"
		#         	Drug.create(
		#             id: line[0, 5],
		#             name: "#{line[5, 32].squeeze(' ').strip}",
		#         	)
		#         end
		#       end
		#     end

  #   filename = Rails.root.join('lib', 'data', 'manual.dat')
  #   File.open(filename, 'r:CP850:utf-8') do |file|
  #     file.each_line do |line|
  #     	product = Product.find_by alfabeta_identifier: line[126, 5]
  #     	unless product.nil?
  #     		PriceHistory.create(product_id: product.id, price: product.price, identifier: identifier)
  #     		reporte = reporte + "Update product #{line[126, 5]};"
  #     		product.update(
  #           troquel_number: line[0, 7],
  #           name: "#{line[7, 44].squeeze(' ').strip}",
  #           presentation_form: "#{line[51, 24].squeeze(' ').strip}",
  #           full_name: "#{line[7, 44].squeeze(' ').strip}, #{line[51, 24].squeeze(' ').strip}",
  #           laboratory: Laboratory.where(name: "#{line[85, 16].squeeze(' ').strip}").first_or_create,
  #           price_in_cents: line[101, 9],
  #           alfabeta_identifier: line[126, 5],
  #           barcode: line[132, 13]
  #       	)
  #       	product.save	
  #     	else
  #     		reporte = reporte + "Create product #{line[126, 5]};"
	 #        Product.create(
	 #            troquel_number: line[0, 7],
	 #            name: "#{line[7, 44].squeeze(' ').strip}",
	 #            presentation_form: "#{line[51, 24].squeeze(' ').strip}",
	 #            full_name: "#{line[7, 44].squeeze(' ').strip}, #{line[51, 24].squeeze(' ').strip}",
	 #            laboratory: Laboratory.where(name: "#{line[85, 16].squeeze(' ').strip}").first_or_create,
	 #            price_in_cents: line[101, 9],
	 #            alfabeta_identifier: line[126, 5],
	 #            barcode: line[132, 13]
	 #        )
	 #      end
  #     end
  #   end


  #   filename = Rails.root.join('lib', 'data', 'MANEXTRA.TXT')
  #   File.open(filename, 'r:CP850:utf-8') do |file|
  #     file.each_line do |line|
  #       p = Product.where(alfabeta_identifier: line[0, 5]).take
  #       unless p.nil?
  #         p.update_column(:drug_id, line[12, 5])
  #         p.save
  #       end
  #     end
  #   end

  #   UpdateLog.create(description: reporte, identifier: identifier)
  end
end