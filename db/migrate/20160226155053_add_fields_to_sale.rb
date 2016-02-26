class AddFieldsToSale < ActiveRecord::Migration
  def change
    add_reference :sales, :health_insurance, index: true, foreign_key: true
    add_reference :sales, :coinsurance, index: true, foreign_key: true
    add_reference :sales, :authorization, index: true, foreign_key: true
  end
end
