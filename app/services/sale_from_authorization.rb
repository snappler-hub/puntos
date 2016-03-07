class SaleFromAuthorization

  def initialize(authorization)
    @authorization = authorization
  end

  def build
    @authorization.client.activate_pending_services
    Sale.new(
        client: @authorization.client,
        seller: @authorization.seller,
        sale_products: sale_products,
        client_points: @authorization.client_points,
        seller_points: @authorization.seller_points,
        health_insurance_id: @authorization.health_insurance_id,
        coinsurance_id: @authorization.coinsurance_id,
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
          amount: product[:amount],
          cost: product[:cost],
          discount: product[:discount],
          client_points: product[:client_points],
          seller_points: product[:seller_points],
          total: product[:total]
      )
    end
  end
end