class AddFieldsToSaleProduct < ActiveRecord::Migration
  def change
    add_reference :sale_products, :health_insurance, index: true, foreign_key: true
    add_reference :sale_products, :coinsurance, index: true, foreign_key: true
  end
end
