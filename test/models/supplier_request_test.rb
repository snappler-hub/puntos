# == Schema Information
#
# Table name: supplier_requests
#
#  id              :integer          not null, primary key
#  supplier_id     :integer
#  user_id         :integer
#  created_by_id   :integer
#  resolution_date :datetime
#  status          :integer          default(0)
#  first_name      :string(255)      not null
#  last_name       :string(255)      not null
#  document_type   :string(255)      not null
#  document_number :string(255)      not null
#  phone           :string(255)
#  email           :string(255)
#  address         :string(255)
#  notes           :text(65535)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class SupplierRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
