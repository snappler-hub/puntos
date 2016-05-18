class CreatePriceHistories < ActiveRecord::Migration
  def change
    create_table :price_histories do |t|
    	t.float :price
      t.references :product, index: true, foreign_key: true
      t.references :alfabeta_update, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end