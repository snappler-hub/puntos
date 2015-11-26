class CreateSale < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :seller_id
      t.integer :client_id
      
      t.timestamps null: false
    end
    add_index :sales, :seller_id
    add_index :sales, :client_id
  end
end
