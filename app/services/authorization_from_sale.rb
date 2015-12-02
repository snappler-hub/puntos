class AuthorizationFromSale

  def initialize(sale, seller)
    @client   = sale.client
    @sale_products = sale.sale_products
    @seller   = seller
    @supplier = seller.supplier
    @points = 0
  end

  def authorize
    #VER COMO CONTROLAR ESTO
    if @client.card_number.nil?
      @status = 'ERROR'
      @message = 'El cliente no posee una tarjeta asignada'
    else
      @status = 'OK'
      @message = ''
    end
    Authorization.new(
      client: @client,
      seller: @seller,
      products: products,
      status: @status,
      message: @message,
      points: @points
    )
  end

  def authorize!
    authorization = authorize
    authorization.save!
    return authorization
  end

  private
  
  def products
    products = []
    @sale_products.map do |sale_product|
      period_product = period_product(sale_product.product)
      discount = discount(sale_product.product)
      accepted_amounts = get_amount_with_and_without_discount(period_product, sale_product.amount)
      amount_with_discount = accepted_amounts[0]
      amount_without_discount = accepted_amounts[1]
      if amount_with_discount == sale_product.amount
        products << create_product(sale_product, amount_with_discount, discount)
      elsif (amount_with_discount == 0)
        products << create_product(sale_product, amount_without_discount, 0)
      else
        products << create_product(sale_product, amount_with_discount, discount)
        products << create_product(sale_product, amount_without_discount, 0)
      end
      #Puntos
      @points += (sale_product.product.points.nil?) ? 0 : (sale_product.amount * sale_product.product.points)
    end
    return products
  end

  #Producto con descuento aplicado
  def create_product(sale_product, amount, discount)
    total = sale_product.cost * amount 
    {
      id: sale_product.product_id,
      amount: amount,
      cost: sale_product.cost,
      discount: discount,
      total: (total * (1- (discount * 0.01) ) )
    }
  end

  #Porcentaje de descuento para un producto
  def discount(product)
    vademecum = @client.vademecums.detect { |vademecum| vademecum.products.include?(product) }
    if vademecum.present? && @supplier.vademecums.include?(vademecum)
      vademecum.discount(product)
    else
      0
    end
  end

  #Si el pfpc existe y está activo, devuelvo el período actual  
  def period_product(product)
    pfpc = @client.pfpc_services.detect { |pfpc| pfpc.products.include?(product) }
    if pfpc.present? && pfpc.in_progress?
      pfpc.last_period.period_products.detect { |pp| pp.product == product }
    else
      nil
    end   
  end
  
  #Devuelve un array con la cantidad a la que corresponde aplicar dto, y cantidad a la que no
  def get_amount_with_and_without_discount(period_product, amount)
    with_discount = 0
    without_discount = amount
    unless period_product.nil?
      remaining = period_product.remaining_amount #Devuelve cero si no puede comprar más
      if (remaining >= amount)
        with_discount = amount
      else
        with_discount = remaining
        without_discount = amount - remaining
      end
    end
    return [with_discount, without_discount]
  end

end