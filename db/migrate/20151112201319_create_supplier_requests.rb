class CreateSupplierRequests < ActiveRecord::Migration
  def change
    create_table :supplier_requests do |t|
      t.belongs_to :supplier, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :created_by_id
      t.datetime :resolution_date
      t.integer :status, default: 0 # Enumerable
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :document_type, null: false
      t.string :document_number, null: false
      t.string :phone
      t.string :email
      t.string :address
      t.text :notes

      t.timestamps null: false
    end
    
    add_index :supplier_requests, :created_by_id
  end
end
