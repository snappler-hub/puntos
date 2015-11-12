class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :crypted_password
      t.string :salt

      t.string :role
      t.string :first_name
      t.string :last_name
      t.integer :created_by_id
      t.belongs_to :supplier, index: true

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end