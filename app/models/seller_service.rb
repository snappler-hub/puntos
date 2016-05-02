# == Schema Information
#
# Table name: services
#
#  id                        :integer          not null, primary key
#  name                      :string(255)      not null
#  type                      :string(255)      not null
#  user_id                   :integer
#  last_period_id            :integer
#  amount                    :float(24)
#  status                    :integer          default(0)
#  days                      :integer          default(30)
#  days_to_points_expiration :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  vademecum_id              :integer
#

class SellerService < Service

  # -- Validations
  validates :amount, presence: true

  # -- Methods
  def self.model_name
    superclass.model_name
  end

  def self.create_for!(user)
    raise 'El usuario no es vendedor' unless user.is?([:seller, :god])
    raise 'El usuario ya cuenta con un servicio de Vendedor asociado' unless user.seller_service.nil?

    self.create!(name: 'Vendedor', user: user, amount: 0, status: Service.statuses[:in_progress])
  end

end

