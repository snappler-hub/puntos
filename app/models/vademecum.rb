# == Schema Information
#
# Table name: vademecums
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vademecum < ActiveRecord::Base

  # -- Scopes
  default_scope -> { order(:name) }

  # -- Associations
  has_many :product_discounts, dependent: :destroy
  has_many :products, through: :product_discounts
  has_many :supplier_vademecums
  has_many :suppliers, through: :supplier_vademecums
  accepts_nested_attributes_for :product_discounts, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :suppliers
  has_many :services

  # -- Validations
  validates :name, presence: true
  
  # -- Misc
  include Destroyable

  # -- Methods
  
  def destroyable?
    services.empty?
  end

  def discount(product)
    product_discounts.detect { |discount| discount.product == product }.discount
  end

  def has?(product)
    product_discounts.any? { |discount| discount.product == product }
  end

  def to_s
    name
  end

end
