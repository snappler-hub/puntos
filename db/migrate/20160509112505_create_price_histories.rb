class CreatePriceHistories < ActiveRecord::Migration
  def change
    create_table :price_histories do |t|
    	t.float :price
      t.integer :product_id
      t.integer :identifier
      t.timestamps null: false
    end
  end
end