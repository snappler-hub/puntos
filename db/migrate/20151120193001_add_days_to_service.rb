class AddDaysToService < ActiveRecord::Migration
  def change
    add_column :services, :days, :integer, default: 30
  end
end
