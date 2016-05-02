# == Schema Information
#
# Table name: sales
#
#  id                  :integer          not null, primary key
#  seller_id           :integer
#  client_id           :integer
#  client_points       :float(24)        default(0.0)
#  seller_points       :float(24)        default(0.0)
#  total               :float(24)        default(0.0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  health_insurance_id :integer
#  coinsurance_id      :integer
#  authorization_id    :integer
#

class Sale < ActiveRecord::Base

  # -- Callbacks
  after_create :send_mail_to_gods, if: :price_greater_than_pvs?

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
  belongs_to :authorization

  # -- Callbacks
  after_save :update_services

  # -- Validations
  validates :seller, presence: true
  validates :client, presence: true

  # -- Methods
  def price_greater_than_pvs?
    greater = false
    sale_products.map do |sp|
      if sp.cost > Product.find(sp.product_id).price
        greater = true
      end
    end
    greater
  end

  def send_mail_to_gods
    # TODO activar
    # title = 'Han vendido un producto con costo mayor al PVS'
    # message = 'Para verla, haga clic en el siguiente botón e ingrese con su usuario y contraseña. '
    # User.with_role('god').map do |god|
    #   url = "/users/#{god.id}/sales/#{id}"
    #   UserMailer.new_mail(god, title, message, 'Nueva venta con costo mayor a pvs', url)
    # end
  end

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
    update_client_points
    update_seller_points
  end

  def update_periods
    id_with_amounts = get_total_amounts(sale_products)
    id_with_amounts.each_pair do |id, amount|
      product = Product.find(id)
      period = PeriodProduct.find_period(client, product)
      if period.present? && client.has_supplier?(seller.supplier)
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
    totals
  end

  def update_client_points
    # si servicio_puntos está activo
    # actualizar ultimo periodo
    if client.has_points_service?
      period = client.points_services.first.last_period
      accumulated_points = client_points
      period.update_accumulated(accumulated_points)
    end
  end

  def update_seller_points
    if seller.has_seller_service?
      seller.cache_points += seller_points
      seller.save!
    end
  end

end
