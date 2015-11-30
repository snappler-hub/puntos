class SaleFromAuthorization

  def initialize(authorization)
    @authorization = authorization
  end

  def build
    Sale.new(
      client: @authorization.client,
      seller: @authorization.seller,
      sale_products: sale_products
    )
  end

  def create
    build.save!
  end

  private

  def sale_products
    @authorization.products.map do |product|
      #binding.pry
      SaleProduct.new(
        product_id: product[:id],
        amount:     product[:amount],
        cost:       product[:cost],
        discount:   product[:discount]
      )
    end
  end
end