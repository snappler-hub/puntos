class CreateRewardOrderItems < ActiveRecord::Migration
  def change
    create_table :reward_order_items do |t|
      t.references :reward_order, index: true, foreign_key: true
      t.references :reward, index: true, foreign_key: true
      t.integer :amount
      t.integer :need_points

      t.timestamps null: false
    end
  end
end
