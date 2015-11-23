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
  
  # -- Validations
  validates :name, :code, presence: true, uniqueness: true

  def to_s
    name
  end
end