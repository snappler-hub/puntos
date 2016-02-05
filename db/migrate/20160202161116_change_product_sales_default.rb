class ChangeProductSalesDefault < ActiveRecord::Migration
  def change
    change_column :sale_products, :amount, :integer, default: '1'
  end
end
