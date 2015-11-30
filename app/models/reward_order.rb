class RewardOrder < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :user
  has_many :reward_order_items, dependent: :destroy


  validates :supplier_id, :user_id, presence: true

  def set_shop_cart(shop_cart)
    shop_cart.each do |x| 
      reward = Reward.where('id = ?', x['item_id']).first
      self.reward_order_items << RewardOrderItem.new(reward_id: reward.id, amount: x['amount'], need_points: reward.need_points) unless(reward.nil?)
    end
    self
  end

end
