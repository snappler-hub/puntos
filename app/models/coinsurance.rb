# == Schema Information
#
# Table name: coinsurances
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class Coinsurance < ActiveRecord::Base

  # -- Scopes
  scope :search, ->(q) { where('name LIKE :q', q: "%#{q}%") }
  
  # -- Associations

  # -- Validations
  validates :name, presence: true

  # -- Methods


end
