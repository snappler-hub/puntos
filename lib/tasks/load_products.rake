namespace :load do
  task  products: :environment do
    filename = Rails.root.join('lib', 'data', 'manual.dat')
    File.open(filename).each do |line|
      line.encode!('UTF-8', 'UTF-8', invalid: :replace)
      Product.create(
        code: line[0,7],
        name: "#{line[7, 44].rstrip}, #{line[51, 24].rstrip}"
      )
    end
  end
end