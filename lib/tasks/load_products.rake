namespace :load do
  task products: :environment do
    filename = Rails.root.join('lib', 'data', 'manual.dat')

    File.open(filename, 'r:iso-8859-1:utf-8') do |file|
      file.each_line do |line|
        puts line[0, 7]
        Product.create(
            code: line[0, 7],
            name: "#{line[7, 44].rstrip}, #{line[51, 24].rstrip}",
            barcode: line[132, 13]
        )
      end
    end

  end
end