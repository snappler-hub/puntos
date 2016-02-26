class RemoveHealthInsuranceAndCoinsuranceFromSaleProduct < ActiveRecord::Migration
  def change
    remove_foreign_key :sale_products, :health_insurance
    remove_index :sale_products, :health_insurance_id
    remove_column :sale_products, :health_insurance_id
    remove_foreign_key :sale_products, :coinsurance
    remove_index :sale_products, :coinsurance_id
    remove_column :sale_products, :coinsurance_id
  end
end
