class RenamePointsFromSale < ActiveRecord::Migration
  def change
    rename_column :sales, :points, :client_points
  end
end
