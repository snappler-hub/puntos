class AddDaysToPointsExpirationToService < ActiveRecord::Migration
  def change
    add_column :services, :days_to_points_expiration, :integer
  end
end
