class RewardOrderItem < ActiveRecord::Base
  belongs_to :reward_order
  belongs_to :reward
end
