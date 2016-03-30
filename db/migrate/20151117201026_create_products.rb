class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      # t.string :code
      t.string :barcode
      t.string :troquel_number

      t.string :name, null: false
      t.string :full_name
      t.float :price_in_cents
      t.string :presentation_form
      # t.boolean :imported
      t.integer :alfabeta_identifier
      # t.integer :units, default: 1
      # t.integer :size # Enumerativo

      t.float :client_points, default: 0
      t.float :seller_points, default: 0

      # t.boolean :deleted, default: 0

      t.references :drug, index: true, foreign_key: true
      t.references :laboratory, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :products, :barcode
    add_index :products, :troquel_number
    add_index :products, :alfabeta_identifier
  end
end
