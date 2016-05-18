class PriceHistory < ActiveRecord::Base
	scope :find_product_id, ->(id) { where("product_id = ?", id) }
end