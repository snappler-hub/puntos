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

user.cards.create(number: '1234-5678-0001')

puts 'END Seed Cards'