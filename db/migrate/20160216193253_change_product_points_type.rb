class ChangeProductPointsType < ActiveRecord::Migration
  def change
    change_column :products, :points, :float
  end
end
