class AddFieldsToAuthorization < ActiveRecord::Migration
  def change
    add_column :authorizations, :status, :string
    add_column :authorizations, :message, :text
    add_column :authorizations, :points, :integer, default: 0
  end
end
