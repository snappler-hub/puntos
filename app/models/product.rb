# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  code       :string(255)      not null
#  name       :string(255)      not null
#  points     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Product < ActiveRecord::Base
  
  # -- Scopes
  default_scope { order(:code) }
  scope :search, ->(q) { where("name LIKE :q", q: "%#{q}%") }
  
  # -- Validations
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

  # -- Methods
  
  def to_s
    name
  end
  
end
