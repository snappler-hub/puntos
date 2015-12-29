class CreatePharmacologicScopes < ActiveRecord::Migration
  def change
    create_table :pharmacologic_scopes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
