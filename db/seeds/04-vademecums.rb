puts 'BEGIN Seed Vademecums with Product Discounts'

Vademecum.where(name: 'Vademecum 1').first_or_create do |v|
  v.name = 'Vademecum 1'
end

Vademecum.where(name: 'Vademecum 2').first_or_create do |v|
  v.name = 'Vademecum 2'
end

ProductDiscount.where(id: 1).first_or_create do |pd|
  pd.product = Product.where(name: 'Bayaspirina C').first
  pd.vademecum = Vademecum.where(name: 'Vademecum 1').first
  pd.discount = 10
end

ProductDiscount.where(id: 2).first_or_create do |pd|
  pd.product = Product.where(name: 'Tafirol').first
  pd.vademecum = Vademecum.where(name: 'Vademecum 2').first
  pd.discount = 20
end

puts 'END Seed Vademecums with Product Discounts'