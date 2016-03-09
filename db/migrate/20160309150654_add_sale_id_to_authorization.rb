class AddSaleIdToAuthorization < ActiveRecord::Migration
  def change
    add_column :authorizations, :sale_id, :integer
  end
end
