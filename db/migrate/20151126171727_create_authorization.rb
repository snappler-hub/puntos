class CreateAuthorization < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.integer :seller_id
      t.integer :client_id
      t.text :products
      t.string :status
      t.text :message
      t.decimal :client_points, precision: 12, scale: 2, default: 0
      t.decimal :seller_points, precision: 12, scale: 2, default: 0
      t.references :sale, index: true
      t.references :health_insurance, index: true
      t.references :coinsurance, index: true
      
      t.timestamps null: false
    end
    add_index :authorizations, :seller_id
    add_index :authorizations, :client_id
  end
end
