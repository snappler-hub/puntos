	class Stock::StockEntry < ActiveRecord::Base
		
  	#--------------------------------------------- RELATION

	  #--------------------------------------------- MISC
	  belongs_to :stock 
	  belongs_to :owner, polymorphic: true 
	  
	  #--------------------------------------------- VALIDATION
	  
	  #--------------------------------------------- CALLBACK
	  after_save :refresh_stock
	  after_destroy :rollback_stock

	  #--------------------------------------------- SCOPES
	  scope :filter_not_applied, -> { where('stock_entries.applied = false') }
	  scope :filter_applied, -> { where('stock_entries.applied = true') }
	  scope :filter_after_entry_date_exclude, ->(date) { where('entry_date > ?', ( (date.class == Date)? date : Date.parse(date)) ) if date.present? }
	  scope :filter_before_entry_date, ->(date) { where('entry_date <= ?', ( (date.class == Date)? date : Date.parse(date)) ) if date.present? }

	  #--------------------------------------------- METHODS

	  def refresh_stock
	  	if(applied)
	  		stock.update(warehouse_stock: (stock.warehouse_stock + amount))
	  		if(special)
	  			stock.update(real_stock: (stock.real_stock + amount)) 
	  		end
	  	end
	  end

	  def rollback_stock
	  	if(applied)
	  		stock.update(warehouse_stock: (stock.warehouse_stock - amount))
	  		if(special)
	  			stock.update(real_stock: (stock.real_stock - amount)) 
	  		end
	  	end
	  end

	  def amount
	  	amount_in_int.to_d / 100 if amount_in_int
	  end
	  
	  def amount=(value)
	  	self.amount_in_int = value.to_d * 100 if value.present?
	  end



	end