class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.integer :points

      t.timestamps null: false
    end
  end
end
