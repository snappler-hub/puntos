# puts 'BEGIN Seed Vademecums with Product Discounts'
#
# ProductDiscount.where(id: 1).first_or_create do |pd|
#   pd.product = Product.where(name: 'Bayaspirina C').first
#   pd.vademecum = Vademecum.where(name: 'V1').first
#   pd.discount = 10
# end
#
# ProductDiscount.where(id: 2).first_or_create do |pd|
#   pd.product = Product.where(name: 'Tafirol').first
#   pd.vademecum = Vademecum.where(name: 'V2').first
#   pd.discount = 20
# end
#
# SupplierVademecum.where(id: 1).first_or_create do |sv|
#   sv.supplier = Supplier.where(name: 'Farmacia Manes').first
#   sv.vademecum = Vademecum.where(name: 'V1').first
# end
#
# puts 'END Seed Vademecums with Product Discounts'