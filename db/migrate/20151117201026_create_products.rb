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
      # t.date :expiration_date
      # t.boolean :imported
      # t.integer :sell_type # Enumerativo
      t.integer :alfabeta_identifier
      # t.integer :units, default: 1
      # t.integer :size # Enumerativo
      # t.string :potency
      # t.integer :relative_presentation_size

      t.float :client_points, default: 0
      t.float :seller_points, default: 0

      # t.boolean :deleted, default: 0

      t.references :drug, index: true, foreign_key: true
      t.references :laboratory, index: true, foreign_key: true
      # t.references :pharmacologic_form, index: true, foreign_key: true
      # t.references :potency_unit, index: true, foreign_key: true
      # t.references :unit_type, index: true, foreign_key: true
      # t.references :administration_route, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :products, :barcode
    add_index :products, :troquel_number
    add_index :products, :alfabeta_identifier
    # add_index :products, :relative_presentation_size
  end
end
