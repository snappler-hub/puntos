class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :username

      t.string :role
      t.string :first_name
      t.string :last_name
      t.belongs_to :supplier, index: true

      t.integer :number
      t.string :document_type
      t.string :document_number
      t.string :phone
      t.string :address


      t.string :card_number, :string
      t.boolean :terms_accepted, default: false
      t.boolean :card_printed, default: false
      t.boolean :card_delivered, default: false

      t.float :cache_points, default: 0

      t.string :image_uid
      t.string :image_name

      t.integer :created_by_id

      t.string :crypted_password
      t.string :salt

      t.string :remember_me_token
      t.datetime :remember_me_token_expires_at

      t.string :reset_password_token, :string
      t.datetime :reset_password_token_expires_at
      t.datetime :reset_password_email_sent_at

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :remember_me_token
    add_index :users, :reset_password_token
  end
end