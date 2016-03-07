class AddFieldsToSupplierPointProduct < ActiveRecord::Migration
  def change
    add_column :supplier_point_products, :seller_points, :decimal, precision: 12, scale: 2, default: 0
    rename_column :supplier_point_products, :points, :client_points
  end
end
