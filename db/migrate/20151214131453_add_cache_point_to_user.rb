class AddCachePointToUser < ActiveRecord::Migration
  def change
    add_column :users, :cache_points, :integer, default: 0
  end
end
