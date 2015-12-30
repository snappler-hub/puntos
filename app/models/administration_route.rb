# == Schema Information
#
# Table name: administration_routes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AdministrationRoute < ActiveRecord::Base
end
