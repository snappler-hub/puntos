puts 'BEGIN Seed Users'

User.where(email: 'marcelo@manes.com.ar').first_or_create do |user|
  user.password = 'marcelo@manes.com.ar'
  user.role = 'god'
  user.first_name = 'Marcelo'
  user.last_name = 'Bauer'
  user.document_number = '12345670'
  user.document_type = 'dni'
  user.supplier = Supplier.where(name: 'Farmacia Manes').first
end

User.where(email: 'perla@manes.com.ar').first_or_create do |user|
  user.password = 'perla@manes.com.ar'
  user.role = 'god'
  user.first_name = 'Perla'
  user.last_name = 'Benigni'
  user.document_number = '12345671'
  user.document_type = 'dni'
  user.created_by_id = 1
  user.supplier = Supplier.where(name: 'Farmacia Manes').first
end

User.where(email: 'drogueria@manes.com.ar').first_or_create do |user|
  user.password = 'drogueria@manes.com.ar'
  user.role = 'admin'
  user.first_name = 'Drogueria'
  user.last_name = 'Manes'
  user.document_number = '12345672'
  user.document_type = 'dni'
  user.created_by_id = 1
  user.supplier = Supplier.where(name: 'Droguería Manes').first
end

puts 'END Seed Users'