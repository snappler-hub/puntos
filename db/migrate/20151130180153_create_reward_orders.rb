class CreateRewardOrders < ActiveRecord::Migration
  def change
    create_table :reward_orders do |t|
      t.references :supplier, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :state
      t.string :code
      t.string :qr_code_uid
      t.string :qr_code_name

      t.timestamps null: false
    end
  end
end
