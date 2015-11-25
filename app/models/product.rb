# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  code       :string(255)      not null
#  name       :string(255)      not null
#  points     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Product < ActiveRecord::Base

  # -- Scopes
  default_scope { order(:code) }
  scope :search, ->(q) { where("name LIKE :q", q: "%#{q}%") }

  # -- Validations
  validates :name, :code, presence: true, uniqueness: true

  def to_s
    name
  end
  
  def self.products_for_service(params_vademecum, user)
    pfpc_services = user.service_pfpcs
    products_in_services = pfpc_services.joins(:products)
    product_ids = products_in_services.pluck(:id)
    
    if params_vademecum
      products = Vademecum.find(params_vademecum).products.where.not(id: product_ids)
    else
      products = Product.all
    end
  end
end