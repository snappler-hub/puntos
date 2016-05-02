# == Schema Information
#
# Table name: products
#
#  id                         :integer          not null, primary key
#  code                       :string(255)      not null
#  barcode                    :string(255)
#  troquel_number             :string(255)
#  name                       :string(255)      not null
#  presentation_form          :string(255)
#  price_in_cents             :float(24)
#  registration_number        :integer
#  units                      :integer          default(1)
#  size                       :integer
#  client_points              :float(24)        default(0.0)
#  seller_points              :float(24)        default(0.0)
#  drug_id                    :integer
#  laboratory_id              :integer
#  deleted                    :boolean          default(FALSE)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class Product < ActiveRecord::Base

  # -- Callbacks
  after_create :initialize_points, if: Proc.new { |u| u.client_points.nil? }

  # -- Associations
  has_many :supplier_point_products
  accepts_nested_attributes_for :supplier_point_products, allow_destroy: true
  belongs_to :drug
  belongs_to :laboratory

  # -- Validations
  validates :name, :alfabeta_identifier, presence: true

  # -- Scopes
  default_scope { order(:name) }
  scope :search, ->(q) { joins(:drug).where('products.name LIKE :a OR products.barcode LIKE :a OR products.troquel_number LIKE :a OR drugs.name LIKE :a OR products.presentation_form LIKE :a', a: "%#{q}%") }

  # -- Methods
  def self.products_for_service(params_vademecum, user)
    pfpc_services = user.pfpc_services.available
    products_in_services = pfpc_services.joins(:product_pfpcs)
    product_ids = products_in_services.pluck(:product_id)

    if params_vademecum
      products = Vademecum.find(params_vademecum).products.where.not(id: product_ids)
    else
      products = Product.all
    end

    products
  end

  def self.points_batch_update(client_points, seller_points, laboratory_id)
    products = (laboratory_id.present?) ? Product.where(laboratory_id: laboratory_id) : Product.all
    products.update_all(client_points: client_points) unless client_points.blank?
    products.update_all(seller_points: seller_points) unless seller_points.blank?
  end

  def to_s
    s = "#{name}"
    s += ", #{presentation_form}" unless presentation_form.nil?
    s
  end

  def price
    price_in_cents.to_d / 100 if price_in_cents
  end

  def initialize_points
    self.update(client_points: 0)
  end

end
