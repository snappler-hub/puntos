class CreateProductReferences < ActiveRecord::Migration
  def change
    create_table :laboratories do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :pharmacologic_forms do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :drugs do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :potency_units do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :unit_types do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :administration_routes do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :presentation_sizes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
