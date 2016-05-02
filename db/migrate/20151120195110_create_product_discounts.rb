class CreateProductDiscounts < ActiveRecord::Migration
  def change
    create_table :health_insurances do |t|
      t.string :name
    end

    create_table :coinsurances do |t|
      t.string :name
    end

    create_table :product_discounts do |t|
      t.belongs_to :product, index: true, foreign_key: true
      t.belongs_to :vademecum, index: true, foreign_key: true
      t.integer :discount, default: 0
      t.integer :health_insurance_discount, default: 0
      t.integer :coinsurance_discount, default: 0
      t.integer :health_insurance_and_coinsurance_discount, default: 0

      t.references :health_insurance, index: true, foreign_key: true
      t.references :coinsurance, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
