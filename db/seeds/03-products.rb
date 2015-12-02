puts 'BEGIN Seed Products'

Product.where(code: '123').first_or_create do |user|
  user.code = '123'
  user.name = 'Bayaspirina C'
end

Product.where(code: '1234').first_or_create do |user|
  user.code = '1234'
  user.name = 'Tafirol'
end

Product.where(code: '12345').first_or_create do |user|
  user.code = '12345'
  user.name = 'Ibupirac'
end

puts 'END Seed Products'