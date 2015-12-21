class AddAlwaysDiscountToService < ActiveRecord::Migration
  def change
    add_column :services, :always_discount, :boolean, default: false
  end
end
