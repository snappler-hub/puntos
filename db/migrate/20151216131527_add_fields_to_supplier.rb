class AddFieldsToSupplier < ActiveRecord::Migration
  def change
    add_column :suppliers, :city, :string
    add_column :suppliers, :address, :string
    add_column :suppliers, :latitude, :string
    add_column :suppliers, :longitude, :string
    add_column :suppliers, :telephone, :string
    add_column :suppliers, :email, :string
    add_column :suppliers, :points_to_client, :boolean
    add_column :suppliers, :points_to_seller, :boolean
    add_column :suppliers, :contact_info, :text
  end
end
