# == Schema Information
#
# Table name: reward_orders
#
#  id           :integer          not null, primary key
#  supplier_id  :integer
#  user_id      :integer
#  state        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  code         :string(255)
#  qr_code_uid  :string(255)
#  qr_code_name :string(255)
#

require 'test_helper'

class RewardOrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
