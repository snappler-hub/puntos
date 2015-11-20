# == Schema Information
#
# Table name: services
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  type       :string(255)      not null
#  user_id    :integer
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  days       :integer
#

class Service < ActiveRecord::Base
 
  # -- Scopes
  default_scope { order(:name) }
 
  # -- Constants
  TYPES = %w(points pfpc)
  
  # -- Associations
  belongs_to :user
  
  # -- Validations
  validates :name, presence: true
  validates :user, presence: true
  validates :days, presence: true
  
  # -- Methods
  
  def to_s 
    name
  end
    
end
