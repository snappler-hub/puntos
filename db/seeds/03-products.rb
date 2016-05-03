# puts 'BEGIN Seed ALFABETA'
#
# Migration.all
#
#
# lab1 = Laboratory.where(name: 'Abbott').first_or_create
# lab2 = Laboratory.where(name: 'Alcon').first_or_create
# lab3 = Laboratory.where(name: 'Eurofarma').first_or_create
#
# puts 'END Seed Laboratories'
#
# puts 'BEGIN Seed Drugs'
#
# drug1 = Drug.where(name: 'Pripozolina').first_or_create
# drug2 = Drug.where(name: 'Tegafur').first_or_create
# drug3 = Drug.where(name: 'Magnesio').first_or_create
#
# puts 'END Seed Drugs'
#
#
# puts 'BEGIN Seed Products'
#
# v1 = Vademecum.where(name: 'V1').first_or_create
# v2 = Vademecum.where(name: 'V2').first_or_create
#
# puts 'END Seed Products'
#
# puts 'BEGIN Seed Products'
#
# p1 = Product.where(code: '123').first_or_create do |product|
#   product.barcode = '123'
#   product.name = 'Bayaspirina C'
#   product.laboratory = lab1
#   product.drug = drug1
#   product.price = 100
# end
#
# p2 = Product.where(code: '1234').first_or_create do |product|
#   product.barcode = '1234'
#   product.name = 'Tafirol'
#   product.laboratory = lab2
#   product.drug = drug2
#   product.price = 150
# end
#
# Product.where(code: '12345').first_or_create do |product|
#   product.barcode = '12345'
#   product.name = 'Ibupirac'
#   product.laboratory = lab3
#   product.drug = drug3
#   product.price = 143
# end
#
# puts 'END Seed Products'
#
# puts 'BEGIN Seed Product Discounts'
#
# ProductDiscount.where(product: p1, vademecum: v1, discount: 15).first_or_create
# ProductDiscount.where(product: p2, vademecum: v1, discount: 25).first_or_create
# ProductDiscount.where(product: p1, vademecum: v2, discount: 10).first_or_create
#
# puts 'END Seed ALFABETA'

Product.destroy_all
Drug.destroy_all
Laboratory.destroy_all


filename = Rails.root.join('lib', 'data', 'monodro.txt')

File.open(filename, 'r:CP850:utf-8') do |file|
  file.each_line do |line|
    Drug.create(
        id: line[0, 5],
        name: "#{line[5, 32].squeeze(' ').strip}",
    )
  end
end


filename = Rails.root.join('lib', 'data', 'manual.dat')

File.open(filename, 'r:CP850:utf-8') do |file|
  file.each_line do |line|
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
end


filename = Rails.root.join('lib', 'data', 'manextra.txt')

File.open(filename, 'r:CP850:utf-8') do |file|
  file.each_line do |line|
    p = Product.where(alfabeta_identifier: line[0, 5]).take
    unless p.nil?
      p.update_column(:drug_id, line[12, 5])
      p.save
    end
  end
end
