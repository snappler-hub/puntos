puts 'BEGIN Seed Cards'

user = User.where(email: 'usuario@final.com').first_or_create do |user|
  user.password = 'usuario@final.com'
  user.role = 'normal_user'
  user.first_name = 'Usuario Uno'
  user.last_name = 'Final'
  user.document_number = '12345674'
  user.document_type = 'dni'
  user.created_by_id = 1
  user.supplier = Supplier.where(name: 'Farmacia Manes').first
end

user2 = User.where(email: 'usuario2@final.com').first_or_create do |user|
  user.password = 'usuario2@final.com'
  user.role = 'normal_user'
  user.first_name = 'Usuario Dos'
  user.last_name = 'Final'
  user.document_number = '10987654'
  user.document_type = 'dni'
  user.created_by_id = 1
  user.supplier = Supplier.where(name: 'Farmacia Manes').first
end

CardManager.assign_card_number!(user)
CardManager.assign_card_number!(user2)

puts 'END Seed Cards'