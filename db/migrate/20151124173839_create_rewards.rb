class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.string  :name, null: false
      t.text 	  :description
      t.string  :code, null: false
      t.integer :need_points
      t.string  :reward_kind, null: false
      t.string :image_uid
      t.string :image_name
      t.text :service_types

      t.timestamps null: false
    end
  end
end