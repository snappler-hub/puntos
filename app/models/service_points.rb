# == Schema Information
#
# Table name: services
#
#  id                        :integer          not null, primary key
#  name                      :string(255)      not null
#  type                      :string(255)      not null
#  user_id                   :integer
#  last_period_id            :integer
#  amount                    :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  days                      :integer          default(30)
#  vademecum_id              :integer
#  status                    :integer          default(0)
#  days_to_points_expiration :integer
#  always_discount           :boolean          default(FALSE)
#

class ServicePoints < Service

  # -- Validations
  validates :amount, presence: true

  # -- Methods
  def self.model_name
    superclass.model_name
  end

end
