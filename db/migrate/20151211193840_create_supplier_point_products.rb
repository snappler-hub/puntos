class CreateSupplierPointProducts < ActiveRecord::Migration
  def change
    create_table :supplier_point_products do |t|
      t.belongs_to :supplier, index: true, foreign_key: true
      t.belongs_to :product, index: true, foreign_key: true
      t.decimal :client_points, precision: 12, scale: 2, default: 0
      t.decimal :seller_points, precision: 12, scale: 2, default: 0

      t.timestamps null: false
    end
  end
end
