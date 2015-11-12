class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :number, :integer
    add_column :users, :document_type, :string
    add_column :users, :document_number, :string
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :username, :string
    add_column :users, :image_uid, :string
    add_column :users, :image_name, :string
  end
end
