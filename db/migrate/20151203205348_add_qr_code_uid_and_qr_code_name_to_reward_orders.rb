class AddQrCodeUidAndQrCodeNameToRewardOrders < ActiveRecord::Migration
  def change
    add_column :reward_orders, :qr_code_uid, :string
    add_column :reward_orders, :qr_code_name, :string
  end
end
