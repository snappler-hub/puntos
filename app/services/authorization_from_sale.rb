class AuthorizationFromSale
  
  attr_accessor :client, :supplier, :response, :seller, :health_insurance_id, :coinsurance_id, :client_points, :seller_points

  def initialize(sale, seller, ticket=nil, response=nil)
    @client = sale.client
    @sale_products = sale.sale_products
    @seller = seller
    @supplier = seller.supplier
    @health_insurance_id = get_health_insurance_id(sale.health_insurance_id)
    @coinsurance_id = get_coinsurance_id(sale.coinsurance_id)
    @response = (response.nil? ? Response.new : response)
    @client_points = 0
    @seller_points = 0
    @ticket = ticket
  end

  def authorize
    check_errors
    Authorization.new(
        client: @client,
        seller: @seller,
        products: get_products,
        status: @response.status,
        message: @response.message,
        health_insurance_id: @health_insurance_id,
        coinsurance_id: @coinsurance_id,
        client_points: @client_points,
        seller_points: @seller_points
    )
  end

  def authorize!
    authorization = authorize
    authorization.save! unless @ticket == 'INFO'
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
    @sale_products.map do |sale_product|
      #Descuentos y puntos
      discounter = Discounter.new(sale_product, self).call
      points_giver = PointsGiver.new(self)
      points_giver.call(sale_product)
      @client_points += points_giver.client_points
      @seller_points += points_giver.seller_points
      products << create_product(sale_product, discounter.discount, points_giver)
    end
    products
  end

  # Producto con descuento aplicado
  def create_product(sale_product, discount, points_giver)
    {
        id: sale_product.product_id,
        name: sale_product.product.full_name,
        barcode: sale_product.product.barcode,
        amount: sale_product.amount,
        to_pay: sale_product.cost,
        pvp: sale_product.product.price.to_f,
        discount: discount,
        client_points: points_giver.client_points,
        seller_points: points_giver.seller_points,
        total: total(sale_product, discount)
    }
  end
  
  def total(sale_product, discount)
    amount = sale_product.amount
    cost = sale_product.cost

    # pvs = sale_product.product.price
    # if sale_product.cost != pvs
    #   return amount * (cost - (pvs * (1 - discount)))
    # else
    #   return (cost * amount) * (1 - discount)
    # end

    (cost * amount) * ((100 - discount) * 0.01)
  end
  
  def get_health_insurance_id(health_insurance_id)
    if health_insurance_id.present?
      HealthInsurance.find_by(id: health_insurance_id).nil? ? nil : health_insurance_id
    else
      nil
    end
  end
  
  def get_coinsurance_id(coinsurance_id)
    if coinsurance_id.present?
      Coinsurance.find_by(id: coinsurance_id).nil? ? nil : coinsurance_id
    else
      nil
    end
  end

end