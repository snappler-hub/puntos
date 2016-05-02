class CreatePathologies < ActiveRecord::Migration
  def change
    create_table :pathologies do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :pathologies_supplier_requests, id: false do |t|
      t.belongs_to :pathology, index: true
      t.belongs_to :supplier_request, index: true
    end
  end
end
