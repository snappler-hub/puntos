class CreatePharmacologicForms < ActiveRecord::Migration
  def change
    create_table :pharmacologic_forms do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
