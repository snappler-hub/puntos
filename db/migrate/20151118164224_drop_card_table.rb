class DropCardTable < ActiveRecord::Migration
  def up
    drop_table :cards
  end

  def down
    create_table :cards do |t|
      t.string :number
      t.belongs_to :user, index: true, foreign_key: true
      t.boolean :terms_accepted, default: false

      t.timestamps null: false
    end
  end
end