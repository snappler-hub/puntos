class SaleFromAuthorization

  def initialize(authorization)
    @authorization = authorization
  end

  def build
    Sale.new(
      client: @authorization.client,
      seller: @authorization.seller,
      sale_products: sale_products,
      points: @authorization.points,
      total: @authorization.total
    )
  end

  def create
    obj = build
    obj.save!
    obj
  end

  private

  def sale_products
    @authorization.products.map do |product|
      SaleProduct.new(
        product_id: product[:id],
        amount:     product[:amount],
        cost:       product[:cost],
        discount:   product[:discount],
        total:      product[:total]
      )
    end
  end
end