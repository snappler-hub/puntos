# == Schema Information
#
# Table name: cards
#
#  id                  :integer          not null, primary key
#  number              :string(255)
#  user_id             :integer
#  terms_accepted      :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  supplier_request_id :integer
#

require 'test_helper'

class CardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
