class CreateVademecums < ActiveRecord::Migration
  def change
    create_table :vademecums do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
