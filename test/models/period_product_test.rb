# == Schema Information
#
# Table name: period_products
#
#  id             :integer          not null, primary key
#  pfpc_period_id :integer
#  product_id     :integer
#  amount         :integer
#  accumulated    :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class PeriodProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
