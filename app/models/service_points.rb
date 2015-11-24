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

class ServicePoints < Service

  # -- Validations
  validates :amount, presence: true

  # -- Methods
  def self.model_name
    superclass.model_name
  end

end