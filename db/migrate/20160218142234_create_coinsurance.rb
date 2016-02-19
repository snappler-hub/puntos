class CreateCoinsurance < ActiveRecord::Migration
  def change
    create_table :coinsurances do |t|
      t.string :name
    end
  end
end
