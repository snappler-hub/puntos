class RewardOrder < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :user
  has_many :reward_order_items, dependent: :destroy


  validates :supplier_id, :user_id, presence: true

  REWARD_ORDER_STATES = %w(confirmed)

  
  def total_amount
    total = 0
    reward_order_items.each{|x| total += x.amount}
    total    
  end

  def total_need_points
    total = 0
    reward_order_items.each{|x| total += x.total_need_points}
    total
  end


  def set_shop_cart(shop_cart)
    shop_cart.each do |x| 
      reward = Reward.where('id = ?', x['item_id']).first
      self.reward_order_items << RewardOrderItem.new(reward_id: reward.id, amount: x['amount'], need_points: reward.need_points) unless(reward.nil?)
    end
    self
  end

end
