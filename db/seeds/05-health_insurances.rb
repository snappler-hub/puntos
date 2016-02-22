puts 'BEGIN Seed HealthInsurances'

HealthInsurance.where(id: 1).first_or_create do |pd|
  pd.name = 'IOMA'
end

HealthInsurance.where(id: 2).first_or_create do |pd|
  pd.name = 'OSDE'
end

puts 'END Seed HealthInsurance'
