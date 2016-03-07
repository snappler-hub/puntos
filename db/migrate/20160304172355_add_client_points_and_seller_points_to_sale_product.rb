class AddClientPointsAndSellerPointsToSaleProduct < ActiveRecord::Migration
  def change
    add_column :sale_products, :client_points, :decimal, precision: 12, scale: 2, default: 0
    add_column :sale_products, :seller_points, :decimal, precision: 12, scale: 2, default: 0
  end
end
