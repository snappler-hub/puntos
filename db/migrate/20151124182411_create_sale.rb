class CreateSale < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :seller_id
      t.integer :client_id
      t.integer :points, default: 0
      t.float :total, default: '0'
      
      t.timestamps null: false
    end
    add_index :sales, :seller_id
    add_index :sales, :client_id
  end
end
