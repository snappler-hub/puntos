class CreateServicePeriods < ActiveRecord::Migration
  def change
    create_table :pfpc_periods do |t|
      t.belongs_to :service, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :status, default: 0 # Enumerative

      t.timestamps null: false
    end
    
    create_table :points_periods do |t|
      t.belongs_to :service, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :status, default: 0 # Enumerative
      t.integer :amount, default: 0
      t.integer :accumulated

      t.timestamps null: false
    end
  end
end