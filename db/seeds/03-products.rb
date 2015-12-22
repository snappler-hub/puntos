puts 'BEGIN Seed Products'

v1 = Vademecum.where(name: 'V1').first_or_create
v2 = Vademecum.where(name: 'V2').first_or_create

puts 'END Seed Products'

puts 'BEGIN Seed Products'

p1 = Product.where(code: '123').first_or_create do |user|
  user.code = '123'
  user.name = 'Bayaspirina C'
end

p2 = Product.where(code: '1234').first_or_create do |user|
  user.code = '1234'
  user.name = 'Tafirol'
end

Product.where(code: '12345').first_or_create do |user|
  user.code = '12345'
  user.name = 'Ibupirac'
end

puts 'END Seed Products'

puts 'BEGIN Seed Product Discounts'

ProductDiscount.where(product: p1, vademecum: v1, discount: 15).first_or_create
ProductDiscount.where(product: p2, vademecum: v1, discount: 25).first_or_create
ProductDiscount.where(product: p1, vademecum: v2, discount: 10).first_or_create

puts 'END Seed Product Discounts'
