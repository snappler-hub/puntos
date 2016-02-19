class CreateHealthInsurance < ActiveRecord::Migration
  def change
    create_table :health_insurances do |t|
      t.string :name
    end
  end
end
