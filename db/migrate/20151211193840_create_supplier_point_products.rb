class CreateSupplierPointProducts < ActiveRecord::Migration
  def change
    create_table :supplier_point_products do |t|
      t.belongs_to :supplier, index: true, foreign_key: true
      t.belongs_to :product, index: true, foreign_key: true
      t.integer :points, default: 0

      t.timestamps null: false
    end
  end
end
