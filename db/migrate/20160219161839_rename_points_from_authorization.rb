class RenamePointsFromAuthorization < ActiveRecord::Migration
  def change
    rename_column :authorizations, :points, :client_points
  end
end
