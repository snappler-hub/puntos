# puts 'BEGIN Seed Suppliers'
#
# Supplier.where(name: 'Farmacia Manes').first_or_create do |supplier|
#   supplier.city = 'La Plata, Buenos Aires'
#   supplier.address = '49 632, La Plata'
#   supplier.latitude = '-34.9150176'
#   supplier.longitude = '-57.951174700000024'
#   supplier.telephone = '0221 422-0550'
#   supplier.points_to_client = true
#   supplier.points_to_seller = true
#   supplier.active = true
# end
#
# puts 'END Seed Suppliers'