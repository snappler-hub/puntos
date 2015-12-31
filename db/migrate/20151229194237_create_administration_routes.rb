class CreateAdministrationRoutes < ActiveRecord::Migration
  def change
    create_table :administration_routes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
