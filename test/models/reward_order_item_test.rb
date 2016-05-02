# == Schema Information
#
# Table name: reward_order_items
#
#  id              :integer          not null, primary key
#  reward_order_id :integer
#  reward_id       :integer
#  amount          :integer
#  need_points     :float(24)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class RewardOrderItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
