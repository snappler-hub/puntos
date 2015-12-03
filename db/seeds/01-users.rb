puts 'BEGIN Seed Users'

u1 = User.where(email: 'marcelo@manes.com.ar').first_or_create do |user|
  user.password = 'marcelo@manes.com.ar'
  user.role = 'god'
  user.first_name = 'Marcelo'
  user.last_name = 'Bauer'
  user.document_number = '12345670'
  user.document_type = 'dni'
  user.supplier = Supplier.where(name: 'Farmacia Manes').first
end

u2 = User.where(email: 'perla@manes.com.ar').first_or_create do |user|
  user.password = 'perla@manes.com.ar'
  user.role = 'god'
  user.first_name = 'Perla'
  user.last_name = 'Benigni'
  user.document_number = '12345671'
  user.document_type = 'dni'
  user.created_by_id = 1
  user.supplier = Supplier.where(name: 'Farmacia Manes').first
end

u3 = User.where(email: 'drogueria@manes.com.ar').first_or_create do |user|
  user.password = 'drogueria@manes.com.ar'
  user.role = 'admin'
  user.first_name = 'Drogueria'
  user.last_name = 'Manes'
  user.document_number = '12345672'
  user.document_type = 'dni'
  user.created_by_id = 1
  user.supplier = Supplier.where(name: 'Droguería Manes').first
end

u4 = User.where(email: 'vendedor@manes.com.ar').first_or_create do |user|
  user.password = 'vendedor@manes.com.ar'
  user.role = 'seller'
  user.first_name = 'Vendedor'
  user.last_name = 'Manes'
  user.document_number = '29876543'
  user.document_type = 'dni'
  user.created_by_id = 1
  user.supplier = Supplier.where(name: 'Droguería Manes').first
end

CardManager.assign_card_number!(u1)
CardManager.assign_card_number!(u2)
CardManager.assign_card_number!(u3)
CardManager.assign_card_number!(u4)

puts 'END Seed Users'