# == Schema Information
#
# Table name: product_pfpcs
#
#  id         :integer          not null, primary key
#  product_id :integer
#  service_id :integer
#  amount     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ProductPfpcTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
