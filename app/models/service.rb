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

class Service < ActiveRecord::Base
 
  # -- Scopes
  default_scope { order(:name) }
 
  # -- Associations
  belongs_to :card
  
  # -- Validations
  validates :name, presence: true
  validates :card, presence: true
  
end
