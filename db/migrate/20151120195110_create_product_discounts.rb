class CreateProductDiscounts < ActiveRecord::Migration
  def change
    create_table :product_discounts do |t|
      t.belongs_to :product, index: true, foreign_key: true
      t.belongs_to :vademecum, index: true, foreign_key: true
      t.float :discount, default: 0

      t.timestamps null: false
    end
  end
end
