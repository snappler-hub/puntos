class ProductFilter
  include ActiveModel::Model
  attr_accessor :code, :name

  def call
    products = Product.all
    products = products.where('code LIKE ?', "%#{@code}%") if @code.present?
    products = products.where('name LIKE ?', "%#{@name}%") if @name.present?
    products
  end
end