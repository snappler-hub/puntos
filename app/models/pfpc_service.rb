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
#

class PfpcService < Service
  
  # -- Associations
  has_many :product_pfpcs, foreign_key: :service_id, dependent: :destroy
  has_many :products, through: :product_pfpcs
  accepts_nested_attributes_for :product_pfpcs, reject_if: :all_blank, allow_destroy: true
  belongs_to :vademecum
  has_many :periods, class_name: "PfpcPeriod", foreign_key: 'service_id', dependent: :destroy
  belongs_to :last_period, class_name: "PfpcPeriod", foreign_key: 'last_period_id'
  
  # -- Validations
  validates :vademecum, presence: true
  
  # -- Callbacks
  after_create :create_period_and_products
  
  # -- Methods 
  
  def in_progress?
    status == "in_progress"
  end
  
  def self.model_name
    superclass.model_name
  end
  
  # Crea un período y le asigna los productos del servicio
  def create_period_and_products
    period = self.create_period
    service_products = self.product_pfpcs.collect { |p| { product_id: p.product_id, amount: p.amount, accumulated: 0 } }
    period.period_products.create(service_products)  
  end
  
  # Creo un período y lo asocio como último período al servicio
  def create_period
    period = self.periods.create do |period|
      period.start_date   = Date.today
      period.end_date     = Date.today + (self.days).days
    end
    
    self.update(last_period: period)
    
    return period
  end
  
end
