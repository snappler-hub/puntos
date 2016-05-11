class CreatePriceHistories < ActiveRecord::Migration
  def change
    create_table :price_histories do |t|
    	t.integer :product_id
    	t.float :price
    	t.integer :identifier
      t.timestamps null: false
    end
  end
end