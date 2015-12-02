# == Schema Information
#
# Table name: pfpc_periods
#
#  id         :integer          not null, primary key
#  service_id :integer
#  start_date :date
#  end_date   :date
#  status     :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PfpcPeriod < ActiveRecord::Base
  
  # -- Associations
  belongs_to :service, class_name:  "Service", foreign_key: "service_id"
  has_many :period_products, dependent: :destroy
  
  # -- Validations
  validates :service, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  
  # -- Statuses
  # in_progress: Período actual (default)
  # accomplished: Período cumplido
  # expired: Período vencido sin cumplir 
  enum status: { in_progress: 0, accomplished: 1, expired: 2, closed: 3 }
  
  # -- Methods  
  # Cambia el estado del periodo
  def mark_as(status)
    self.status = status
    self.save
  end
  
  # True si tiene productos pendientes
  def can_renew?
    !self.period_products.exists?(["accumulated < amount"])
  end
  
  # Renuevo un período. Copio los productos del período copiando el 
  # sobrante (acumulado - cant a cumplir) al nuevo período
  def renew
    new_period = self.service.create_period

    # Armo la estructura para hacer la inserción de productos masiva
    service_products = self.period_products.collect { |p| 
      { 
        product_id: p.product_id, 
        amount: p.amount, 
        accumulated: (p.accumulated < p.amount) ? 0 : (p.accumulated - p.amount) 
      } 
    }
    new_period.period_products.create(service_products)  
  end
  
  # Reinicio el período reseteando los días y pongo el estado En Curso
  def restart
    self.start_date = Date.today
    self.end_date = Date.today + (self.service.days).days
    self.status = :in_progress
    self.save
  end
  
end
