class AddFieldsToProductDiscount < ActiveRecord::Migration
  def change
    add_reference :product_discounts, :health_insurance, index: true, foreign_key: true
    add_reference :product_discounts, :coinsurance, index: true, foreign_key: true
  end
end
