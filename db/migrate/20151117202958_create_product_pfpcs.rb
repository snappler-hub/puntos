class CreateProductPfpcs < ActiveRecord::Migration
  def change
    create_table :product_pfpcs do |t|
      t.belongs_to :product, index: true, foreign_key: true
      t.belongs_to :service, index: true, foreign_key: true
      t.integer :amount, null: false
      t.timestamps null: false
    end
  end
end
