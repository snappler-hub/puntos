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

  # -- ASSOCIATIONS
  has_many :users
  has_many :services, through: :users
  has_many :point_services, through: :users
  has_many :pfpc_services, through: :users
  has_many :supplier_requests
  has_many :supplier_vademecums
  has_many :vademecums, through: :supplier_vademecums
  has_many :supplier_point_products
  accepts_nested_attributes_for :supplier_point_products, allow_destroy: true

  # -- VALIDATIONS
  validates :name, presence: true

  # -- SCOPES
  scope :active, -> { where(active: true) }

  # -- METHODS
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
