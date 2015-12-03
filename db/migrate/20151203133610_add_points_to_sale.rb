class AddPointsToSale < ActiveRecord::Migration
  def change
    add_column :sales, :points, :integer, default: 0
  end
end
