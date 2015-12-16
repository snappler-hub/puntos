# == Schema Information
#
# Table name: stocks
#
#  id                     :integer          not null, primary key
#  real_stock_in_int      :integer          default(0)
#  warehouse_stock_in_int :integer          default(0)
#  stockable_id           :integer
#  stockable_type         :string(255)
#  store_id               :integer
#  store_type             :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

	class Stock::Stock < ActiveRecord::Base

	  #--------------------------------------------- RELATION

	  #--------------------------------------------- MISC
	  belongs_to :stockable, polymorphic: true  
	  belongs_to :store, polymorphic: true  
	  has_many :stock_entries, dependent: :destroy
	  validates :store_id, uniqueness: {scope: [:store_type, :stockable_id, :stockable_type]}
	  #--------------------------------------------- VALIDATION

	  #--------------------------------------------- CALLBACK

	  #--------------------------------------------- SCOPES

	  #--------------------------------------------- METHODS

	  def real_stock
	  	real_stock_in_int.to_d / 100 if real_stock_in_int
	  end
	  
	  def real_stock=(value)
	  	self.real_stock_in_int = value.to_d * 100 if value.present?
	  end

	  def warehouse_stock
	  	warehouse_stock_in_int.to_d / 100 if warehouse_stock_in_int
	  end
	  
	  def warehouse_stock=(value)
	  	self.warehouse_stock_in_int = value.to_d * 100 if value.present?
	  end

	  def generate_stock_entry(hash)
	  	owner = hash[:owner]
	  	amount = hash[:amount]
	  	entry_date = hash[:date] || Date.today
	  	special = hash[:special]
	  	applied = hash[:applied]
	  	codename = hash[:codename]	  	
	  	observation = hash[:observation]	  	
	  	new_stock_entry = ::Stock::StockEntry.new(observation: observation, codename: codename, owner: owner, amount: amount, entry_date: entry_date, applied: applied, special: special)
	  	stock_entries << new_stock_entry
	  	return new_stock_entry
	  end


	  def stock_hard_down(hash)
	  	hash[:amount] = hash[:amount].to_i * -1
	  	hash[:special] = true
	  	hash[:applied] = hash[:applied] || true
	  	generate_stock_entry(hash)
	  end

	  def stock_hard_up(hash)
	  	hash[:amount] = hash[:amount].to_i
	  	hash[:special] = true
	  	hash[:applied] = hash[:applied] || true
	  	generate_stock_entry(hash)
	  end

	  def stock_soft_down(hash)
	  	hash[:amount] = hash[:amount].to_i * -1
	  	hash[:special] = false
	  	hash[:applied] = hash[:applied] || false
	  	generate_stock_entry(hash)
	  end

	  def stock_soft_up(hash)
	  	hash[:amount] = hash[:amount].to_i
	  	hash[:special] = false
	  	hash[:applied] = hash[:applied] || false
	  	generate_stock_entry(hash)
	  end


	  def get_stock_for_date(date=nil)
	  	date = date || Date.today
	  	


	  	#Son los movimientos NO APLICADOS - ANTES DE LA FECHA
	  	entries_amount = stock_entries.filter_not_applied.filter_before_entry_date(date).sum(:amount_in_int).to_d / 100
	  	
	  	#Son los movimientos APLICADOS - DESPUES DE LA FECHA - CON VALOR INVERTIDO ***
	  	entries_amount += stock_entries.filter_after_entry_date_exclude(date).filter_applied.sum('amount_in_int * -1').to_d / 100


	  	(entries_amount + warehouse_stock).to_f
	  end


	  def print
	  	"TOTAL: #{real_stock}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;POSESION: #{warehouse_stock}".html_safe
	  end






end
