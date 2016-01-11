class CreatePotencyUnits < ActiveRecord::Migration
  def change
    create_table :potency_units do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
