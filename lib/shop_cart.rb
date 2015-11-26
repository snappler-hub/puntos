class ShopCart
	

	def self.new(session)
		if(session[:current_shop_cart_items].nil?)
			session[:current_shop_cart_items] = []
		end
		session[:current_shop_cart_items]
	end

	def self.reset(session)
		session[:current_shop_cart_items] = []
		session[:current_shop_cart_items]
	end


	def self.find(session, sub_product_id)
		session[:current_shop_cart_items].select{|x| x['sub_product_id'] == sub_product_id}.first
	end


	def self.add(session, sub_product_id)
		current_order_item = ShopCart::find(session, sub_product_id)
		if(current_order_item.nil?)
			current_order_item = {}
			current_order_item['sub_product_id'] = sub_product_id
			current_order_item['amount'] = 1
			session[:current_shop_cart_items] << current_order_item
			current_order_item
		end
	end

	def self.sub(session, sub_product_id)
		current_order_item = ShopCart::find(session, sub_product_id)
		unless(current_order_item.nil?)
			session[:current_shop_cart_items].delete(current_order_item)
		end
	end

	def self.inc(session, sub_product_id)
		current_order_item = ShopCart::find(session, sub_product_id)
		unless(current_order_item.nil?)
			current_order_item['amount'] += 1
			current_order_item
		end
	end

	def self.dec(session, sub_product_id)
		current_order_item = ShopCart::find(session, sub_product_id)
		unless(current_order_item.nil?)
			current_order_item['amount'] -= 1
			current_order_item
		end
	end


end  