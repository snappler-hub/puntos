# == Schema Information
#
# Table name: product_discounts
#
#  id                                        :integer          not null, primary key
#  product_id                                :integer
#  vademecum_id                              :integer
#  discount                                  :float(24)        default(0.0)
#  created_at                                :datetime         not null
#  updated_at                                :datetime         not null
#  health_insurance_id                       :integer
#  coinsurance_id                            :integer
#  health_insurance_discount                 :float(24)        default(0.0)
#  coinsurance_discount                      :float(24)        default(0.0)
#  health_insurance_and_coinsurance_discount :float(24)        default(0.0)
#

require 'test_helper'

class ProductDiscountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
