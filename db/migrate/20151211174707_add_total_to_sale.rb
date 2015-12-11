class AddTotalToSale < ActiveRecord::Migration
  def change
    add_column :sales, :total, :float, default: '0'
  end
end
