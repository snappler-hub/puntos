class CreateAuthorization < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.integer :seller_id
      t.integer :client_id
      t.text :products
      t.string :status
      t.text :message
      t.float :client_points, default: 0
      t.float :seller_points, default: 0
      
      t.timestamps null: false
    end
    add_index :authorizations, :seller_id
    add_index :authorizations, :client_id
  end
end
