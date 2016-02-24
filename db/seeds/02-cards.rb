# puts 'BEGIN Seed Cards'
#
# user = User.where(email: 'tkd.inbox@gmail.com').first_or_create do |user|
#   user.password = 'tkd.inbox@gmail.com'
#   user.role = 'normal_user'
#   user.first_name = 'Francisco'
#   user.last_name = 'Peña'
#   user.document_number = '31020394'
#   user.document_type = 'dni'
#   user.created_by_id = 1
#   user.supplier = Supplier.where(name: 'Farmacia Manes').first
# end
#
# CardManager.assign_card_number!(user)
# CardManager.assign_card_number!(user2)
#
# puts 'END Seed Cards'