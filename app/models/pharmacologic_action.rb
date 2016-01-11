# == Schema Information
#
# Table name: pharmacologic_actions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PharmacologicAction < ActiveRecord::Base
end
