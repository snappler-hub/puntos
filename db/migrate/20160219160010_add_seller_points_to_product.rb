class AddSellerPointsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :seller_points, :float
  end
end
