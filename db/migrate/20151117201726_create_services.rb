class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :amount

      t.timestamps null: false
    end
  end
end
