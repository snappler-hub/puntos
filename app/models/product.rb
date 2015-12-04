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
#  barcode    :string(255)
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
    pfpc_services = user.pfpc_services
    products_in_services = pfpc_services.joins(:product_pfpcs)
    product_ids = products_in_services.pluck(:product_id)
    
    if params_vademecum
      products = Vademecum.find(params_vademecum).products.where.not(id: product_ids)
    else
      products = Product.all
    end
    
    products
  end
end
