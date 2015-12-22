class AddStatusToService < ActiveRecord::Migration
  def change
    add_column :services, :status, :integer, default: 0 # Enumerative
  end
end
