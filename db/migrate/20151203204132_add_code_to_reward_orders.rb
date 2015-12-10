class AddCodeToRewardOrders < ActiveRecord::Migration
  def change
    add_column :reward_orders, :code, :string
  end
end
