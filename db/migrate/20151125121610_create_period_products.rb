class CreatePeriodProducts < ActiveRecord::Migration
  def change
    create_table :period_products do |t|
      t.belongs_to :service_period, index: true, foreign_key: true
      t.belongs_to :product, index: true, foreign_key: true
      t.integer :amount
      t.integer :accumulated, default: 0

      t.timestamps null: false
    end
  end
end
