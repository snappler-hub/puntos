# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  code       :string(255)      not null
#  name       :string(255)      not null
#  points     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  barcode    :string(255)
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end