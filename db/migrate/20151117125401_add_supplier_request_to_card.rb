class AddSupplierRequestToCard < ActiveRecord::Migration
  def change
    add_reference :cards, :supplier_request, index: true, foreign_key: true
  end
end
