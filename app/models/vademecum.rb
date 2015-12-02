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
  accepts_nested_attributes_for :product_discounts, reject_if: :all_blank, allow_destroy: true

  # -- Validations
  validates :name, presence: true

  # -- Methods

  def discount(product)
    product_discounts.detect{ |discount| discount.product == product }.discount
  end

  def has?(product)
    product_discounts.any? {|discount| discount.product == product}
  end

  def to_s
    name
  end

end
