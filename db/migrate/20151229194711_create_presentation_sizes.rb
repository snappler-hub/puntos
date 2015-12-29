class CreatePresentationSizes < ActiveRecord::Migration
  def change
    create_table :presentation_sizes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
