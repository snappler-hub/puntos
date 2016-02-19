class AddSellerPointsToSale < ActiveRecord::Migration
  def change
    add_column :sales, :seller_points, :float
  end
end
