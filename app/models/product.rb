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
#  price                      :float(24)
#  expiration_date            :date
#  imported                   :boolean
#  sell_type                  :integer
#  registration_number        :integer
#  units                      :integer          default(1)
#  size                       :integer
#  potency                    :string(255)
#  relative_presentation_size :integer
#  client_points              :float(24)        default(0.0)
#  seller_points              :float(24)        default(0.0)
#  pharmacologic_action_id    :integer
#  drug_id                    :integer
#  pharmacologic_form_id      :integer
#  potency_unit_id            :integer
#  unit_type_id               :integer
#  administration_route_id    :integer
#  laboratory_id              :integer
#  deleted                    :boolean          default(FALSE)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class Product < ActiveRecord::Base

  # -- Associations
  has_many :supplier_point_products
  accepts_nested_attributes_for :supplier_point_products, allow_destroy: true
  belongs_to :administration_route
  belongs_to :drug
  belongs_to :pharmacologic_form
  belongs_to :potency_unit
  belongs_to :unit_type
  belongs_to :pharmacologic_scope
  belongs_to :laboratory

  # -- Scopes
  default_scope { order(:name) }

  scope :search, ->(q) { where('products.name LIKE :a OR products.barcode LIKE :b OR products.troquel_number LIKE :c OR drugs.name LIKE :a', a: "%#{q}%", b: "#{q}%", c: "#{q}%") }

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

  # -- Validations
  validates :name, presence: true
  # validates :code, :barcode, uniqueness: true

  # -- Callbacks
  after_create :initialize_points, if: Proc.new { |u| u.client_points.nil? }

  def to_s
    s = "#{name}"
    s += ", #{presentation_form}" unless presentation_form.nil?
    s
  end
  
  def name_with_presentation
    unless presentation_form.nil?
      "#{name} - #{presentation_form}"
    else
      "#{name}"
    end
  end

  def initialize_points
    self.update(client_points: 0)
  end

end
