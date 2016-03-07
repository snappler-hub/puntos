class ChangeSupplierPointProduct < ActiveRecord::Migration
  def self.up
    change_column :supplier_point_products, :client_points, :decimal, precision: 12, scale: 2, default: 0
  end
  
  def self.down
    change_column :supplier_point_products, :client_points, :float
  end
end
