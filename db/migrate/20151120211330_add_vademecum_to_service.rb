class AddVademecumToService < ActiveRecord::Migration
  def change
    add_reference :services, :vademecum, index: true, foreign_key: true
  end
end
