class AddTotalToSaleProduct < ActiveRecord::Migration
  def change
    add_column :sale_products, :total, :float, default: 0
  end
end
