class AddDiscountFieldsToProductDiscount < ActiveRecord::Migration
  def change
    add_column :product_discounts, :health_insurance_discount, :float, default: 0
    add_column :product_discounts, :coinsurance_discount, :float, default: 0
    add_column :product_discounts, :health_insurance_and_coinsurance_discount, :float, default: 0
  end
end
