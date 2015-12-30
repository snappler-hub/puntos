# == Schema Information
#
# Table name: drugs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Drug < ActiveRecord::Base
  
  # -- Scopes
  scope :search, ->(q) { where('name LIKE :q', q: "%#{q}%") }
  
  # -- Methods
  
  # 
  def to_s
    name
  end
  
end
