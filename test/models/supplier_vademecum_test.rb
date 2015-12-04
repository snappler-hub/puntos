# == Schema Information
#
# Table name: supplier_vademecums
#
#  id           :integer          not null, primary key
#  supplier_id  :integer
#  vademecum_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class SupplierVademecumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
