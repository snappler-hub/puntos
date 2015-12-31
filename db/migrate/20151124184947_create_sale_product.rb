class CreateSaleProduct < ActiveRecord::Migration
  def change
    create_table :sale_products do |t|
      t.references :product, index: true, foreign_key: true
      t.references :sale, index: true, foreign_key: true
      t.integer :amount, default: '0'
      t.float :cost, default: '0'
      t.float :discount, default: '0'
      t.float :total, default: 0
      
      t.timestamps
    end
  end
end
