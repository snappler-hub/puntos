class AddCardInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :card_number, :string
    add_column :users, :terms_accepted, :boolean, default: false
    add_column :users, :card_printed, :boolean, default: false
    add_column :users, :card_delivered, :boolean, default: false
    add_reference :users, :supplier_request, index: true, foreign_key: true
  end
end