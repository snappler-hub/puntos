class ChangeFieldTypesFromSale < ActiveRecord::Migration
  def self.up
    change_column :sales, :client_points, :decimal, precision: 12, scale: 2, default: 0
    change_column :sales, :seller_points, :decimal, precision: 12, scale: 2, default: 0
  end
  
  def self.down
    change_column :sales, :client_points, :float
    change_column :sales, :seller_points, :float
  end
end
