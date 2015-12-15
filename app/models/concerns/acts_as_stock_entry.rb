module ActsAsStockEntry

  extend ActiveSupport::Concern

  included do
   	has_many :stock_entries, class_name: 'Stock::StockEntry', as: :owner, dependent: :destroy   
  	has_one :stock_entry, class_name: 'Stock::StockEntry', as: :owner, dependent: :destroy


  end

end