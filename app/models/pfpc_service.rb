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

class PfpcService < Service

  # -- Associations
  has_many :product_pfpcs, foreign_key: :service_id, dependent: :destroy
  has_many :products, through: :product_pfpcs
  has_many :pfpc_suppliers
  has_many :suppliers, through: :pfpc_suppliers
  accepts_nested_attributes_for :product_pfpcs, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :pfpc_suppliers, reject_if: :all_blank, allow_destroy: true
  belongs_to :vademecum
  has_many :periods, class_name: 'PfpcPeriod', foreign_key: 'service_id', dependent: :destroy
  belongs_to :last_period, class_name: 'PfpcPeriod', foreign_key: 'last_period_id'

  # -- Validations
  validates :vademecum, presence: true

  # -- Callbacks
  after_create :create_period_and_products
  after_create :send_mail #Los términos y condiciones tienen que volver a aceptarse cada vez q le crean un pfpc, así que le envío mail

  # -- Methods

  def available?
    status == 'in_progress' || status == 'pending'
  end

  def self.model_name
    superclass.model_name
  end

  # Crea un período y le asigna los productos del servicio
  def create_period_and_products
    period = self.create_period
    service_products = self.product_pfpcs.collect { |p| {product: p.product, amount: p.amount, accumulated: 0} }
    period.period_products.create(service_products)
  end

  # Creo un período y lo asocio como último período al servicio
  def create_period
    period = self.periods.create do |period|
      period.start_date = Date.today
      period.end_date = Date.today + (self.days).days
    end

    self.update(last_period: period)

    period
  end

  def can_renew?
    last_period.can_renew?
  end

  def send_mail
    title = 'Debe aceptar los términos y condiciones'
    message = 'Para ello, haga clic en el siguiente botón e ingrese con su usuario y contraseña. '
    UserMailer.new_mail(self.user, title, message)
  end

end
