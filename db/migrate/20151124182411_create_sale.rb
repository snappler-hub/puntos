class CreateSale < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :seller_id
      t.integer :client_id
      t.decimal :client_points, precision: 12, scale: 2, default: 0
      t.decimal :seller_points, precision: 12, scale: 2, default: 0

      t.references :health_insurance, index: true
      t.references :coinsurance, index: true
      t.references :authorization, index: true

      t.float :total, default: 0
      
      t.timestamps null: false
    end
    add_index :sales, :seller_id
    add_index :sales, :client_id
  end
end
