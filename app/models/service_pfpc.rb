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

class ServicePfpc < Service
  
  # -- Associations
  has_many :product_pfpcs, foreign_key: :service_id, dependent: :destroy
  has_many :products, through: :product_pfpcs
  accepts_nested_attributes_for :product_pfpcs, reject_if: :all_blank, allow_destroy: true
  belongs_to :vademecum
  has_many :service_periods, foreign_key: :service_id, dependent: :destroy
  
  # -- Validations
  validates :vademecum, presence: true
  
  # -- Misc 
  enum status: { pending: 0, in_progress: 1, finished: 2 }
  
  # -- Methods 
  
  def self.model_name
    superclass.model_name
  end
  
  # Creo un período y le asocio los productos
  def create_period
    period = ServicePeriod.create do |period|
      period.service_id   = self.id
      period.start_date   = Date.today
      period.end_date     = Date.today + (self.days).days
    end
    
    service_products = self.product_pfpcs.collect { |p| { product_id: p.product_id, amount: p.amount } }
    period.period_products.create(service_products)  
  end
  
end
