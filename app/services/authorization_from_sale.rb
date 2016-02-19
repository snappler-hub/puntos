class AuthorizationFromSale
  
  attr_accessor :client, :supplier, :response, :seller

  def initialize(sale, seller)
    @client = sale.client
    @sale_products = sale.sale_products
    @seller = seller
    @supplier = seller.supplier
    @response = Response.new
    @client_points = 0
    @seller_points = 0
  end

  def authorize
    check_errors
    Authorization.new(
        client: @client,
        seller: @seller,
        products: get_products,
        status: @response.status,
        message: @response.message,
        client_points: @client_points,
        seller_points: @seller_points
    )
  end

  def authorize!
    authorization = authorize
    authorization.save!
    authorization
  end

  private

  def check_errors
    if @supplier.active?
      unless @client.terms_accepted?
        @response.add_error('El cliente debe aceptar los términos de uso para poder operar en el sistema.')
      end
    else
      @response.add_error('El vendedor no tiene permisos para operar ya que su prestador no está activo.')
    end
  end

  def get_products
    if @response.ok?
      products
    else
      nil
    end
  end

  def products
    products = []
    points_giver = PointsGiver.new(self)
    @sale_products.map do |sale_product|
      # Productos con descuentos
      discounter = Discounter.new(sale_product, self).call
      products << create_product(sale_product, discounter.discount)

      #Puntos
      points_giver.call(sale_product)
      @client_points += points_giver.client_points
      @seller_points += points_giver.seller_points
    end
    products
  end

  # Producto con descuento aplicado
  def create_product(sale_product, discount)
    total = sale_product.cost * sale_product.amount
    {
        id: sale_product.product_id,
        amount: sale_product.amount,
        cost: sale_product.cost,
        health_insurance_id: sale_product.health_insurance_id,
        coinsurance_id: sale_product.coinsurance_id,
        discount: discount,
        total: (total * (1- (discount * 0.01)))
    }
  end

end