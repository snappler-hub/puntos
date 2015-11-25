# == Schema Information
#
# Table name: service_periods
#
#  id         :integer          not null, primary key
#  service_id :integer
#  start_date :date
#  end_date   :date
#  status     :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ServicePeriodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
