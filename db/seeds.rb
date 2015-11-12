# Carga todos los archivos de la carpeta db/seeds en orden alfabético
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }