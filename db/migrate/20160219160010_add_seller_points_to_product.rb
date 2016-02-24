class AddSellerPointsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :seller_points, :float, default: 0
  end
end
