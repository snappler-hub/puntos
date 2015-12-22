class CreateAuthorization < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.integer :seller_id
      t.integer :client_id
      t.text :products
      
      t.timestamps null: false
    end
    add_index :authorizations, :seller_id
    add_index :authorizations, :client_id
  end
end
