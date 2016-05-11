class CreateUpdateLogs < ActiveRecord::Migration
  def change
    create_table :update_logs do |t|
    	t.text :description, limit: 4294967295
    	t.integer :identifier
      t.timestamps null: false
    end
  end
end