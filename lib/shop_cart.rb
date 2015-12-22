class ShopCart

  def self.new(session)
    if session[:current_shop_cart_items].nil?
      session[:current_shop_cart_items] = []
    end
    session[:current_shop_cart_items]
  end

  def self.reset(session)
    session[:current_shop_cart_items] = []
    session[:current_shop_cart_items]
  end


  def self.find(session, item_id)
    session[:current_shop_cart_items].select { |x| x['item_id'] == item_id }.first
  end


  def self.add(session, item_id, need_points)
    current_order_item = ShopCart::find(session, item_id)
    if current_order_item.nil?
      current_order_item = {}
      current_order_item['item_id'] = item_id
      current_order_item['amount'] = 1
      current_order_item['need_points'] = need_points
      session[:current_shop_cart_items] << current_order_item
      current_order_item
    end
  end

  def self.sub(session, item_id)
    current_order_item = ShopCart::find(session, item_id)
    unless current_order_item.nil?
      session[:current_shop_cart_items].delete(current_order_item)
    end
  end

  def self.inc(session, item_id)
    current_order_item = ShopCart::find(session, item_id)
    unless current_order_item.nil?
      current_order_item['amount'] += 1
      current_order_item
    end
  end

  def self.dec(session, item_id)
    current_order_item = ShopCart::find(session, item_id)
    unless current_order_item.nil?
      current_order_item['amount'] -= 1
      current_order_item
    end
  end

  def self.need_points(session)
    total = 0
    session[:current_shop_cart_items].each do |item|
      total += (item['need_points'] * item['amount'])
    end

    total
  end
end  