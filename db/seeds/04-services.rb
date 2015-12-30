# puts 'BEGIN Seed Services'
#
# PfpcService.where(name: 'Super PFPC').first_or_create do |service|
#   service.user = User.where(email: 'usuario@final.com').first
#   service.days = 30
#   service.vademecum = Vademecum.first
# end
#
# PointsService.where(name: 'Golazo de Puntos').first_or_create do |service|
#   service.user = User.where(email: 'usuario@final.com').first
#   service.days = 30
#   service.amount = 400
# end
#
# puts 'END Seed Services'