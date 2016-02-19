class AddSellerPointsToAuthorization < ActiveRecord::Migration
  def change
    add_column :authorizations, :seller_points, :float
  end
end
