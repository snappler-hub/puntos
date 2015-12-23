# == Schema Information
#
# Table name: suppliers
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  description      :text(65535)
#  active           :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  city             :string(255)
#  address          :string(255)
#  latitude         :string(255)
#  longitude        :string(255)
#  telephone        :string(255)
#  email            :string(255)
#  points_to_client :boolean
#  points_to_seller :boolean
#  contact_info     :text(65535)
#

class Supplier < ActiveRecord::Base

  include Destroyable

  # -- Associations
  has_many :users
  has_many :services, through: :users
  has_many :point_services, through: :users
  has_many :pfpc_services, through: :users
  has_many :supplier_requests
  has_many :supplier_vademecums
  has_many :vademecums, through: :supplier_vademecums
  has_many :supplier_point_products
  accepts_nested_attributes_for :supplier_point_products, allow_destroy: true
  accepts_nested_attributes_for :vademecums, allow_destroy: true

  # -- Validations
  validates :name, presence: true

  # -- Callbacks
  after_validation :reverse_geocode

  # -- Scopes
  scope :active, -> { where(active: true) }
  scope :with_location, -> { where('latitude is not null and longitude is not null') }


  # -- Misc
  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.city = "#{geo.city}, #{geo.state}"
    end
  end

  acts_as_mappable default_units: :kms,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude

  # -- Methods

  def destroyable?
    users.empty?
  end

  def to_param
    "#{id}-#{name}".parameterize
  end

  def to_s
    name
  end

  def clients_get_points?
    points_to_client
  end

  def sellers_get_points?
    points_to_seller
  end

end
