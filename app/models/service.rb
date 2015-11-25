# == Schema Information
#
# Table name: services
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  type         :string(255)      not null
#  user_id      :integer
#  amount       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  days         :integer          default(30)
#  vademecum_id :integer
#  status       :integer          default(0)
#

class Service < ActiveRecord::Base

  # -- Scopes
  default_scope { order(:name) }

  # -- Constants
  TYPES = %w(points pfpc)
  
  # -- Associations
  belongs_to :user

  # -- Validations
  validates :name, :user, :days, presence: true

  def to_s 
    name
  end

end
