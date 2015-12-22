# == Schema Information
#
# Table name: suppliers
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  description      :text(65535)
#  active           :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  city             :string(255)
#  address          :string(255)
#  latitude         :string(255)
#  longitude        :string(255)
#  telephone        :string(255)
#  email            :string(255)
#  points_to_client :boolean
#  points_to_seller :boolean
#  contact_info     :text(65535)
#

require 'test_helper'

class SupplierTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
