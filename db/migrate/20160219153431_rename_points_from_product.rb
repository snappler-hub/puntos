class RenamePointsFromProduct < ActiveRecord::Migration
  def change
    rename_column :products, :points, :client_points
  end
end
