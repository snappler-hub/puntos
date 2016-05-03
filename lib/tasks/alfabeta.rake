namespace :alfabeta do

  task seed: :environment do

    Product.destroy_all
    Drug.destroy_all
    Laboratory.destroy_all


    filename = Rails.root.join('lib', 'data', 'monodro.txt')

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


    filename = Rails.root.join('lib', 'data', 'manextra.txt')

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