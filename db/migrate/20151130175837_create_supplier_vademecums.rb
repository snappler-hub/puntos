class CreateSupplierVademecums < ActiveRecord::Migration
  def change
    create_table :supplier_vademecums do |t|
      t.belongs_to :supplier, index: true, foreign_key: true
      t.belongs_to :vademecum, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
