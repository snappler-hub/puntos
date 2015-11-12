puts 'BEGIN Seed Suppliers'

Supplier.where(name: 'Farmacia Manes').first_or_create do |supplier|
  supplier.description = 'Servicios farmacéuticos, droguería, farmacia'
  supplier.active = true
end

Supplier.where(name: 'Droguería Manes').first_or_create do |supplier|
  supplier.description = 'Servicios farmacéuticos, droguería, farmacia'
  supplier.active = true
end

puts 'END Seed Suppliers'