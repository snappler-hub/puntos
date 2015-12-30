class CreatePharmacologicActions < ActiveRecord::Migration
  def change
    create_table :pharmacologic_actions do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
