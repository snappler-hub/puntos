class CreatePfpcSupplier < ActiveRecord::Migration
  def change
    create_table :pfpc_suppliers do |t|
      t.references :pfpc_service, index: true
      t.references :supplier, index: true, foreign_key: true
    end
    add_foreign_key :pfpc_suppliers, :services, column: :pfpc_service_id
  end
end
