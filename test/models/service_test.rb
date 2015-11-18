# == Schema Information
#
# Table name: services
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  type       :string(255)      not null
#  card_id    :integer
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
