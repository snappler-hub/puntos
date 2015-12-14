class AddAvailableToPointsPeriod < ActiveRecord::Migration
  def change
    add_column :points_periods, :available, :integer, default: 0
  end
end
