class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :last_period_id
      t.integer :amount

      t.integer :status, default: 0 # Enumerative
      t.integer :days, default: 30
      t.integer :days_to_points_expiration

      t.timestamps null: false
    end
    add_index :services, :last_period_id
  end
end