puts 'BEGIN Seed Users'

manes = Supplier.where(name: 'Farmacia Manes').first

u1 = User.where(email: 'marcelo@manes.com.ar').first_or_create do |user|
  user.password = 'marcelo@manes.com.ar'
  user.role = 'god'
  user.first_name = 'Marcelo'
  user.last_name = 'Bauer'
  user.document_number = '12938281'
  user.document_type = 'dni'
  user.supplier = manes
end

u2 = User.where(email: 'perla@manes.com.ar').first_or_create do |user|
  user.password = 'perla@manes.com.ar'
  user.role = 'god'
  user.first_name = 'Perla'
  user.last_name = 'Benigni'
  user.document_number = '28967543'
  user.document_type = 'dni'
  user.created_by_id = 1
  user.supplier = manes
end

u3 = User.where(email: 'vendedor@manes.com.ar').first_or_create do |user|
  user.password = 'vendedor@manes.com.ar'
  user.role = 'seller'
  user.first_name = 'Vendedor'
  user.last_name = 'Manes'
  user.document_number = '29876543'
  user.document_type = 'dni'
  user.created_by_id = 1
  user.supplier = manes
end

CardManager.assign_card_number!(u1)
CardManager.assign_card_number!(u2)
CardManager.assign_card_number!(u3)

puts 'END Seed Users'