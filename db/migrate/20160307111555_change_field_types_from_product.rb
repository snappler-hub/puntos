class ChangeFieldTypesFromProduct < ActiveRecord::Migration
  def self.up
    change_column :products, :client_points, :decimal, precision: 12, scale: 2, default: 0
    change_column :products, :seller_points, :decimal, precision: 12, scale: 2, default: 0
  end
  
  def self.down
    change_column :products, :client_points, :float
    change_column :products, :seller_points, :float
  end
end
