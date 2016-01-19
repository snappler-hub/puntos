class RemoveRequestFromUser < ActiveRecord::Migration
  def change
    remove_foreign_key :users, :supplier_request
    remove_index :users, :supplier_request_id
    remove_column :users, :supplier_request_id
  end
end