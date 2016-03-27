class ChangeColumnsTypeInProductDiscount < ActiveRecord::Migration
  def change
    change_column :product_discounts, :discount, :integer, default: 0
    change_column :product_discounts, :health_insurance_discount, :integer, default: 0
    change_column :product_discounts, :coinsurance_discount, :integer, default: 0
    change_column :product_discounts, :health_insurance_and_coinsurance_discount, :integer, default: 0
  end
end
