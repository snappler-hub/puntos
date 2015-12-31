class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.text :description
      t.string :city
      t.string :address
      t.string :latitude
      t.string :longitude
      t.string :telephone
      t.string :email
      t.text :contact_info
      t.boolean :points_to_client
      t.boolean :points_to_seller
      t.boolean :active

      t.timestamps null: false
    end
  end
end
