puts 'BEGIN Seed Users'

manes = Supplier.where(name: 'Farmacia Manes').first

# u = User.where(email: 'marcelo@manes.com.ar').first_or_create do |user|
#   user.password = 'marcelo@manes.com.ar'
#   user.role = 'god'
#   user.first_name = 'Marcelo'
#   user.last_name = 'Bauer'
#   user.document_number = '12938281'
#   user.document_type = 'dni'
#   user.supplier = manes
# end
# CardManager.assign_card_number!(u)

# u = User.where(email: 'perla@manes.com.ar').first_or_create do |user|
#   user.password = 'perla@manes.com.ar'
#   user.role = 'god'
#   user.first_name = 'Perla'
#   user.last_name = 'Benigni'
#   user.document_number = '28967543'
#   user.document_type = 'dni'
#   user.created_by_id = 1
#   user.supplier = manes
# end
# CardManager.assign_card_number!(u)


u = User.where(email: '11797403@manes.com.ar').first_or_create do |user|
  user.password = '11797403@manes.com.ar'
  user.number = 5237
  user.last_name = 'Impellizzeri'
  user.first_name = 'Mario Alfredo'
  user.document_type = 'dni'
  user.document_number = '11797403'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '22765234@manes.com.ar').first_or_create do |user|
  user.password = '22765234@manes.com.ar'
  user.number = 5011
  user.last_name = 'Romero'
  user.first_name = 'Pablo Christian'
  user.document_type = 'dni'
  user.document_number = '22765234'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '21845452@manes.com.ar').first_or_create do |user|
  user.password = '21845452@manes.com.ar'
  user.number = 5012
  user.last_name = 'Iglesias'
  user.first_name = 'Roberto Julian'
  user.document_type = 'dni'
  user.document_number = '21845452'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '18369725@manes.com.ar').first_or_create do |user|
  user.password = '18369725@manes.com.ar'
  user.number = 5028
  user.last_name = 'Mend\rCardManager.assign_card_number!(u)ez'
  user.first_name = 'Ramon Eduardo'
  user.document_type = 'dni'
  user.document_number = '18369725'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '20415681@manes.com.ar').first_or_create do |user|
  user.password = '20415681@manes.com.ar'
  user.number = 5050
  user.last_name = 'Giardinieri'
  user.first_name = 'Ricardo Miguel'
  user.document_type = 'dni'
  user.document_number = '20415681'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '11995299@manes.com.ar').first_or_create do |user|
  user.password = '11995299@manes.com.ar'
  user.number = 5211
  user.last_name = 'Villanueva'
  user.first_name = 'Americo Rodolfo'
  user.document_type = 'dni'
  user.document_number = '11995299'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '24771686@manes.com.ar').first_or_create do |user|
  user.password = '24771686@manes.com.ar'
  user.number = 5315
  user.last_name = 'Gonzalez Grasias'
  user.first_name = 'Jorge Javier'
  user.document_type = 'dni'
  user.document_number = '24771686'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '27815141@manes.com.ar').first_or_create do |user|
  user.password = '27815141@manes.com.ar'
  user.number = 5341
  user.last_name = 'Miranda'
  user.first_name = 'Jorge Andres'
  user.document_type = 'dni'
  user.document_number = '27815141'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '18774865@manes.com.ar').first_or_create do |user|
  user.password = '18774865@manes.com.ar'
  user.number = 5407
  user.last_name = 'Narro Castañeda'
  user.first_name = 'Julissa Francis'
  user.document_type = 'dni'
  user.document_number = '18774865'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '31345639@manes.com.ar').first_or_create do |user|
  user.password = '31345639@manes.com.ar'
  user.number = 5416
  user.last_name = 'Becerra'
  user.first_name = 'Lucas Ezequiel'
  user.document_type = 'dni'
  user.document_number = '31345639'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '27408941@manes.com.ar').first_or_create do |user|
  user.password = '27408941@manes.com.ar'
  user.number = 5417
  user.last_name = 'Castellani Perez'
  user.first_name = 'Carla Paola'
  user.document_type = 'dni'
  user.document_number = '27408941'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '29371797@manes.com.ar').first_or_create do |user|
  user.password = '29371797@manes.com.ar'
  user.number = 5433
  user.last_name = 'Chaves'
  user.first_name = 'Nancy Edith'
  user.document_type = 'dni'
  user.document_number = '29371797'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '36174925@manes.com.ar').first_or_create do |user|
  user.password = '36174925@manes.com.ar'
  user.number = 5448
  user.last_name = 'Camiolo'
  user.first_name = 'Juan Fernando'
  user.document_type = 'dni'
  user.document_number = '36174925'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '27280198@manes.com.ar').first_or_create do |user|
  user.password = '27280198@manes.com.ar'
  user.number = 5453
  user.last_name = 'Altamira'
  user.first_name = 'Hernan Gabriel'
  user.document_type = 'dni'
  user.document_number = '27280198'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '33480732@manes.com.ar').first_or_create do |user|
  user.password = '33480732@manes.com.ar'
  user.number = 5454
  user.last_name = 'Martijena'
  user.first_name = 'Antonela Cintia'
  user.document_type = 'dni'
  user.document_number = '33480732'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '32801312@manes.com.ar').first_or_create do |user|
  user.password = '32801312@manes.com.ar'
  user.number = 5455
  user.last_name = 'Almada'
  user.first_name = 'Maria Delfina'
  user.document_type = 'dni'
  user.document_number = '32801312'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '32312960@manes.com.ar').first_or_create do |user|
  user.password = '32312960@manes.com.ar'
  user.number = 5456
  user.last_name = 'Echever'
  user.first_name = 'Maria Fernanda'
  user.document_type = 'dni'
  user.document_number = '32312960'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '34780682@manes.com.ar').first_or_create do |user|
  user.password = '34780682@manes.com.ar'
  user.number = 5461
  user.last_name = 'Llada'
  user.first_name = 'Juan Francisco'
  user.document_type = 'dni'
  user.document_number = '34780682'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '31029186@manes.com.ar').first_or_create do |user|
  user.password = '31029186@manes.com.ar'
  user.number = 5435
  user.last_name = 'Bauer'
  user.first_name = 'Facundo Jorge'
  user.document_type = 'dni'
  user.document_number = '31029186'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '36301857@manes.com.ar').first_or_create do |user|
  user.password = '36301857@manes.com.ar'
  user.number = 5446
  user.last_name = 'Cameroni'
  user.first_name = 'Laura Andrea'
  user.document_type = 'dni'
  user.document_number = '36301857'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '36273391@manes.com.ar').first_or_create do |user|
  user.password = '36273391@manes.com.ar'
  user.number = 5458
  user.last_name = 'Villiani'
  user.first_name = 'Juan Manuel'
  user.document_type = 'dni'
  user.document_number = '36273391'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '22020184@manes.com.ar').first_or_create do |user|
  user.password = '22020184@manes.com.ar'
  user.number = 5128
  user.last_name = 'Grimoldi'
  user.first_name = 'Gabriela Maria'
  user.document_type = 'dni'
  user.document_number = '22020184'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '10686227@manes.com.ar').first_or_create do |user|
  user.password = '10686227@manes.com.ar'
  user.number = 5062
  user.last_name = 'Alvarez'
  user.first_name = 'Daniel Guillermo'
  user.document_type = 'dni'
  user.document_number = '10686227'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '26683296@manes.com.ar').first_or_create do |user|
  user.password = '26683296@manes.com.ar'
  user.number = 5160
  user.last_name = 'Staropoli'
  user.first_name = 'Nestor Sergio Omar'
  user.document_type = 'dni'
  user.document_number = '26683296'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '28215626@manes.com.ar').first_or_create do |user|
  user.password = '28215626@manes.com.ar'
  user.number = 5409
  user.last_name = 'Benigni'
  user.first_name = 'Perla Alejandra'
  user.document_type = 'dni'
  user.document_number = '28215626'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '26598186@manes.com.ar').first_or_create do |user|
  user.password = '26598186@manes.com.ar'
  user.number = 5441
  user.last_name = 'Capararo'
  user.first_name = 'Ariel Omar'
  user.document_type = 'dni'
  user.document_number = '26598186'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '12754340@manes.com.ar').first_or_create do |user|
  user.password = '12754340@manes.com.ar'
  user.number = 5031
  user.last_name = 'Ferrere'
  user.first_name = 'Maria Alejandra'
  user.document_type = 'dni'
  user.document_number = '12754340'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '25022830@manes.com.ar').first_or_create do |user|
  user.password = '25022830@manes.com.ar'
  user.number = 5343
  user.last_name = 'David'
  user.first_name = 'Nilda Dafne'
  user.document_type = 'dni'
  user.document_number = '25022830'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '31225538@manes.com.ar').first_or_create do |user|
  user.password = '31225538@manes.com.ar'
  user.number = 5429
  user.last_name = 'Prado'
  user.first_name = 'Jesus Ernesto'
  user.document_type = 'dni'
  user.document_number = '31225538'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '28347873@manes.com.ar').first_or_create do |user|
  user.password = '28347873@manes.com.ar'
  user.number = 5398
  user.last_name = 'Gutierrez'
  user.first_name = 'Maria Cristina'
  user.document_type = 'dni'
  user.document_number = '28347873'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '29227149@manes.com.ar').first_or_create do |user|
  user.password = '29227149@manes.com.ar'
  user.number = 5397
  user.last_name = 'Laguarta'
  user.first_name = 'Leandro Orlando'
  user.document_type = 'dni'
  user.document_number = '29227149'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

u = User.where(email: '17666602@manes.com.ar').first_or_create do |user|
  user.password = '17666602@manes.com.ar'
  user.number = 014421
  user.last_name = 'Barcelo'
  user.first_name = 'Rossana Angela'
  user.document_type = 'dni'
  user.document_number = '17666602'
  user.role = 'seller'
  user.created_by_id = 1
  user.supplier = manes
end
CardManager.assign_card_number!(u)
SellerService.create_for!(u)

puts 'END Seed Users'