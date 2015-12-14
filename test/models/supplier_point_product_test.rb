# == Schema Information
#
# Table name: supplier_point_products
#
#  id          :integer          not null, primary key
#  supplier_id :integer
#  product_id  :integer
#  points      :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class SupplierPointProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
