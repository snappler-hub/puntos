namespace :alfabeta do

  desc 'Obtiene de la API REST los zip de la base de datos'
  task update: :environment do

    id = (UpdateLog.last.nil? ? '14000' : UpdateLog.last.identifier.to_s)

    while true
      response_me = RestClient.get "http://web.alfabeta.net/update?usr=alejandra&pw=ale372&src=ME&id=#{id}"
      response_md = RestClient.get "http://web.alfabeta.net/update?usr=alejandra&pw=ale372&src=MD&id=#{id}"

      break if response_md.code == 204


      filename_me = response_me.headers[:content_disposition].split('=').last
      filename_md = response_md.headers[:content_disposition].split('=').last
      zip_file_path_me = File.join(Rails.root, 'lib', 'data', filename_me)
      zip_file_path_md = File.join(Rails.root, 'lib', 'data', filename_md)
      unzip_file_path = File.join(Rails.root, 'lib', 'data', filename_md[0..filename_md.size-10]) # Es indistinto que filename use

      File.open(zip_file_path_me, 'wb') do |file|
        RestClient.get "http://web.alfabeta.net/update?usr=alejandra&pw=ale372&src=ME&id=#{id}" do |binary_response|
          file.write binary_response
        end
      end

      Zip::File.open(zip_file_path_me) do |zip_file|
        entry = zip_file.glob('monodro.txt').first
        FileUtils::mkdir_p(unzip_file_path)
        zip_file.extract(entry, "#{unzip_file_path}/#{entry.name}")
        entry = zip_file.glob('manextra.txt').first
        zip_file.extract(entry, "#{unzip_file_path}/#{entry.name}")
      end

      File.open(zip_file_path_md, 'wb') do |file|
        RestClient.get "http://web.alfabeta.net/update?usr=alejandra&pw=ale372&src=MD&id=#{id}" do |binary_response|
          file.write binary_response
        end
      end

      Zip::File.open("./lib/data/#{filename_md}") do |zip_file|
        entry = zip_file.glob('manual.dat').first
        FileUtils::mkdir_p(unzip_file_path)
        zip_file.extract(entry, "#{unzip_file_path}/#{entry.name}")
      end

      reporte = {drug: [], product: []}
      products = []
      drugs = []
      prices = []
      update_product = []

      filename = "#{unzip_file_path}/monodro.txt"
      File.open(filename, 'r:CP850:utf-8') do |file|
        file.each_line do |line|
          drug = Drug.find_by name: "#{line[5, 32].squeeze(' ').strip}"
          drug_hash = {description: "Drug id: #{line[0, 5]}"}
          file_drug = Drug.new
          file_drug.id = line[0, 5]
          file_drug.name = "#{line[5, 32].squeeze(' ').strip}"
          if drug.nil?
            reporte[:drug] << drug_hash.merge({action: 'Create'})
          else
            reporte[:drug] << drug_hash.merge({action: 'Update'})
          end
          drugs << file_drug
        end
        Drug.import drugs, :on_duplicate_key_update => [:name]
        puts 'terminaron las drogas'
      end


      filename = "#{unzip_file_path}/manual.dat"
      File.open(filename, 'r:CP850:utf-8') do |file|
        file.each_line do |line|
          product = Product.find_by alfabeta_identifier: line[126, 5]
          product_hash = {description: "Product alfabeta_identifier: #{line[126, 5]}"}

          if product.nil?
            reporte[:product] << product_hash.merge({action: 'Create'})
            product = Product.new
            product.troquel_number = line[0, 7]
            product.name = "#{line[7, 44].squeeze(' ').strip}"
            product.presentation_form = "#{line[51, 24].squeeze(' ').strip}"
            product.full_name = "#{line[7, 44].squeeze(' ').strip}, #{line[51, 24].squeeze(' ').strip}"
            product.laboratory_id = (Laboratory.where(name: "#{line[85, 16].squeeze(' ').strip}").first_or_create).id
            product.price_in_cents = line[101, 9]
            product.alfabeta_identifier = line[126, 5]
            product.barcode = line[132, 13]
          else
            prices << [product.id, product.price, id.to_i]
            reporte[:product] << product_hash.merge({action: 'Update'})
            product.troquel_number = line[0, 7]
            product.name = "#{line[7, 44].squeeze(' ').strip}"
            product.presentation_form = "#{line[51, 24].squeeze(' ').strip}"
            product.full_name = "#{line[7, 44].squeeze(' ').strip}, #{line[51, 24].squeeze(' ').strip}"
            product.laboratory_id = (Laboratory.where(name: "#{line[85, 16].squeeze(' ').strip}").first_or_create).id
            product.price_in_cents = line[101, 9]
            product.alfabeta_identifier = line[126, 5]
            product.barcode = line[132, 13]
          end
          products << product
        end
        p 'productos creados y cargados al array'

        Product.import products, on_duplicate_key_update: [:barcode, :troquel_number, :name, :full_name, :price_in_cents, :presentation_form, :alfabeta_identifier, :laboratory_id]
        p 'productos en la db'
        PriceHistory.import [:product_id, :price, :identifier], prices
        p 'hitorial de precios en la db'
      end


      filename = "#{unzip_file_path}/manextra.txt"
      File.open(filename, 'r:CP850:utf-8') do |file|
        file.each_line do |line|
          p = Product.where(alfabeta_identifier: line[0, 5]).take
          unless p.nil?
            p.drug_id = line[12, 5]
            update_product << p
          end
        end
        Product.import update_product, on_duplicate_key_update: [:drug_id]
        p 'se updatearon los drug_id'
      end

      id = response_me.headers[:numero]
      UpdateLog.create(description: reporte, identifier: id.to_i)
    end

  end

  task seed: :environment do

    Product.destroy_all
    Drug.destroy_all
    Laboratory.destroy_all


    filename = Rails.root.join('lib', 'data', 'MONODRO.TXT')

    File.open(filename, 'r:CP850:utf-8') do |file|
      file.each_line do |line|
        Drug.create(
            id: line[0, 5],
            name: "#{line[5, 32].squeeze(' ').strip}",
        )
      end
    end


    filename = Rails.root.join('lib', 'data', 'manual.dat')

    File.open(filename, 'r:CP850:utf-8') do |file|
      file.each_line do |line|
        Product.create(
            troquel_number: line[0, 7],
            name: "#{line[7, 44].squeeze(' ').strip}",
            presentation_form: "#{line[51, 24].squeeze(' ').strip}",
            full_name: "#{line[7, 44].squeeze(' ').strip}, #{line[51, 24].squeeze(' ').strip}",
            laboratory: Laboratory.where(name: "#{line[85, 16].squeeze(' ').strip}").first_or_create,
            price_in_cents: line[101, 9],
            alfabeta_identifier: line[126, 5],
            barcode: line[132, 13]
        )
      end
    end


    filename = Rails.root.join('lib', 'data', 'MANEXTRA.TXT')

    File.open(filename, 'r:CP850:utf-8') do |file|
      file.each_line do |line|
        p = Product.where(alfabeta_identifier: line[0, 5]).take
        unless p.nil?
          p.update_column(:drug_id, line[12, 5])
          p.save
        end
      end
    end

  end
end

namespace :database do
  task cleanup: :environment do
    Sale.destroy_all
    Authorization.destroy_all
    Comment.destroy_all
    PeriodProduct.destroy_all
    PfpcPeriod.destroy_all
    PfpcSupplier.destroy_all
    PointsPeriod.destroy_all
    ProductDiscount.destroy_all
    ProductPfpc.destroy_all
    RewardOrderItem.destroy_all
    RewardOrder.destroy_all
    Reward.destroy_all
    SaleProduct.destroy_all
    SupplierPointProduct.destroy_all
    Service.destroy_all
    Vademecum.destroy_all
  end
end