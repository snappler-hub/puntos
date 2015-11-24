class ProductDiscount < ActiveRecord::Base

  # -- Associations
  belongs_to :product
  belongs_to :vademecum

  # Validations
  validates :product, uniqueness: { scope: :vademecum,
    message: 'ya está en uso. Verifique no tener productos repetidos' }
end