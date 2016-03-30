class CreateSaleProduct < ActiveRecord::Migration
  def change
    create_table :sale_products do |t|
      t.references :product, index: true, foreign_key: true
      t.references :sale, index: true, foreign_key: true
      t.integer :amount, default: 1
      t.float :cost, default: 0
      t.float :discount, default: 0
      t.float :total, default: 0
      t.decimal :client_points, precision: 12, scale: 2, default: 0
      t.decimal :seller_points, precision: 12, scale: 2, default: 0

      t.references :health_insurance, index: true
      t.references :coinsurance, index: true
      
      t.timestamps
    end
  end
end
