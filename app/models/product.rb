# == Schema Information
#
# Table name: products
#
#  id                         :integer          not null, primary key
#  code                       :string(255)      not null
#  name                       :string(255)      not null
#  points                     :integer
#  barcode                    :string(255)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  presentation_form          :string(255)
#  price                      :float(24)
#  expiration_date            :date
#  imported                   :boolean
#  sell_type                  :integer
#  registration_number        :integer
#  deleted                    :boolean          default(FALSE)
#  units                      :integer          default(1)
#  size                       :integer
#  potency                    :string(255)
#  troquel_number             :string(255)
#  relative_presentation_size :integer
#  pharmacologic_action_id    :integer
#  drug_id                    :integer
#  pharmacologic_form_id      :integer
#  potency_unit_id            :integer
#  unit_type_id               :integer
#  administration_route_id    :integer
#  laboratory_id              :integer
#

class Product < ActiveRecord::Base

  # -- Scopes
  default_scope { order(:code) }
  scope :search, ->(q) { where('name LIKE :q OR code like :c', q: "%#{q}%", c: "#{q}%") }

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

  # -- Validations
  validates :name, presence: true
  # validates :code, :barcode, uniqueness: true

  # -- Callbacks
  after_create :initialize_points, if: Proc.new { |u| u.points.nil? }

  def to_s
    s = "#{name}"
    s += ", #{presentation_form}" unless presentation_form.nil?
    s
  end

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

  def self.points_batch_update(points, laboratory_id)
    products = (laboratory_id.present?) ? Product.where(laboratory_id: laboratory_id) : Product.all
    products.update_all(points: points)
  end
  
  def name_with_presentation
    unless presentation_form.nil?
      "#{name} - #{presentation_form}"
    else
      "#{name}"
    end
  end

  def initialize_points
    self.update(points: 0)
  end

end
