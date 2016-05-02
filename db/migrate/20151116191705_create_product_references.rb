class CreateProductReferences < ActiveRecord::Migration
  def change
    create_table :laboratories do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :drugs do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
