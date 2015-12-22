# == Schema Information
#
# Table name: sales
#
#  id         :integer          not null, primary key
#  seller_id  :integer
#  client_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  points     :integer          default(0)
#  total      :float(24)        default(0.0)
#

class Sale < ActiveRecord::Base

  # -- Scopes
  default_scope -> { order('created_at DESC') }
  scope :all_from_seller, ->(user) { where(seller_id: user) }
  scope :all_from_client, ->(user) { where(client_id: user) }

  # -- Associations
  has_many :sale_products, dependent: :destroy
  accepts_nested_attributes_for :sale_products, allow_destroy: true
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
  belongs_to :client, class_name: 'User', foreign_key: 'client_id'
  has_one :supplier, through: :seller

  # -- Callbacks
  after_save :update_services

  # -- Validations
  validates :seller, presence: true
  validates :client, presence: true

  # -- Methods
  def total
    sale_products.reduce(0) { |sum, sale_product| sum + sale_product.total }
  end

  def self.all_from_supplier(supplier_id)
    self.joins(:supplier).where(:suppliers => {id: supplier_id})
  end

  def self.between_dates(start_date, finish_date)
    self.where('date(sales.created_at) BETWEEN ? AND ?', start_date.to_date, finish_date.to_date)
  end

  def update_services
    #Acá se van a ir llamando todos los callbacks como actualizar periodo, actualizar puntos, etc
    update_periods
    update_points
  end

  def update_periods
    id_with_amounts = get_total_amounts(sale_products)
    id_with_amounts.each_pair do |id, amount|
      product = Product.find(id)
      period = PeriodProduct.find_period(client, product)
      unless period.nil?
        period.add_to_accumulated(amount)
      end
    end
  end

  def get_total_amounts(sale_products)
    id_with_sales = sale_products.group_by { |sp| sp.product_id }
    totals = {}
    id_with_sales.each do |id, sales_array|
      id_total = sales_array.reduce(0) { |sum, sa| sum + sa.amount }
      totals[id] = id_total
    end
    return totals
  end
  
  def update_points
    #si servicio_puntos está activo
    #actualizar ultimo periodo
    if client.has_points_service?
      period = client.points_services.first.last_period
      accumulated_points = points
      period.update_accumulated(accumulated_points)
    end
  end

end
