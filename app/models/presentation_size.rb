# == Schema Information
#
# Table name: presentation_sizes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PresentationSize < ActiveRecord::Base
end
