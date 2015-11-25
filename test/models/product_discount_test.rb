# == Schema Information
#
# Table name: product_discounts
#
#  id           :integer          not null, primary key
#  product_id   :integer
#  vademecum_id :integer
#  discount     :float(24)        default(0.0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class ProductDiscountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
