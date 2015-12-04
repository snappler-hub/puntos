# == Schema Information
#
# Table name: reward_order_items
#
#  id              :integer          not null, primary key
#  reward_order_id :integer
#  reward_id       :integer
#  amount          :integer
#  need_points     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class RewardOrderItem < ActiveRecord::Base
  belongs_to :reward_order
  belongs_to :reward


  def total_need_points
  	need_points * amount
  end
end
