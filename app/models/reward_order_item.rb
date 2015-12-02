class RewardOrderItem < ActiveRecord::Base
  belongs_to :reward_order
  belongs_to :reward


  def total_need_points
  	need_points * amount
  end
end
