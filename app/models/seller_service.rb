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

