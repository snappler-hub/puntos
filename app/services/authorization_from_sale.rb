class AuthorizationFromSale

  def initialize(sale, seller)
    @client = sale.client
    @sale_products = sale.sale_products
    @seller = seller
    @supplier = seller.supplier
    @points = 0
  end

  def authorize
    check_errors
    Authorization.new(
        client: @client,
        seller: @seller,
        products: get_products,
        status: @status,
        message: @message,
        points: @points
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
        @status = Const::STATUS_ERROR
        @message = 'El cliente debe aceptar los términos de uso para poder operar en el sistema. '
      else
        @status = Const::STATUS_OK
        @message = ''
      end
    else
      @status = Const::STATUS_ERROR
      @message = 'El vendedor no tiene permisos para operar ya que su prestador no está activo. '
    end
  end

  def get_products
    if @status == Const::STATUS_OK
      products
    else
      nil
    end
  end

  def products
    products = []
    @sale_products.map do |sale_product|

      #Productos con descuentos
      period_product = period_product(sale_product.product)
      discount = discount(sale_product.product)
      
      accepted_amounts = get_amount_with_and_without_discount(period_product, sale_product.amount)
      amount_with_discount = accepted_amounts[0]
      amount_without_discount = accepted_amounts[1]
      if amount_with_discount == sale_product.amount
        products << create_product(sale_product, amount_with_discount, discount)
      elsif amount_with_discount == 0
        products << create_product(sale_product, amount_without_discount, 0)
      else
        products << create_product(sale_product, amount_with_discount, discount)
        products << create_product(sale_product, amount_without_discount, 0)
      end
      
      #Puntos
      calculate_points(sale_product)
    end

    products
  end

  def calculate_points(sale_product)
    if @client.has_points_service? && @supplier.clients_get_points?
      @points += (sale_product.amount * get_points(sale_product.product, @supplier))
    else
      @status = Const::STATUS_WARNING
      @message += 'El cliente no posee un servicio de puntos activo o el prestador no otorga puntos. '
    end
  end

  #Producto con descuento aplicado
  def create_product(sale_product, amount, discount)
    total = sale_product.cost * amount
    {
        id: sale_product.product_id,
        amount: amount,
        cost: sale_product.cost,
        discount: discount,
        total: (total * (1- (discount * 0.01)))
    }
  end

  #Porcentaje de descuento para un producto
  def discount(product)
    vademecum = @client.vademecums.detect { |vademecum| vademecum.products.include?(product) }
    if vademecum.present? && @supplier.vademecums.include?(vademecum)
      vademecum.discount(product)
    else
      @status = Const::STATUS_WARNING
      @message += 'No se encontró un vademecum, por lo que no se aplicarán descuentos. '
      0
    end
  end

  #Si el pfpc existe y está activo, devuelvo el período actual  
  def period_product(product)
    pfpc = @client.pfpc_services.detect { |pfpc| pfpc.products.include?(product) }
    if pfpc.present? && pfpc.in_progress?
      pfpc.last_period.period_products.detect { |pp| pp.product == product }
    else
      @status = Const::STATUS_WARNING
      @message += 'El cliente no posee ningún pfpc o período activo. '
      nil
    end
  end

  #Devuelve array con dos valores: la cant. a la que corresponde aplicar dto y cant. a la que no
  def get_amount_with_and_without_discount(period_product, amount)
    with_discount = 0
    without_discount = amount
    unless period_product.nil?
      remaining = get_remaining_amount(period_product)      
      if remaining >= amount
        with_discount = amount
      else
        with_discount = remaining
        without_discount = amount - remaining
      end
    end

    [with_discount, without_discount]
  end
  
  def get_remaining_amount(period_product)
    #Si en el pfpc está marcada la opción de descontar siempre, la cantidad con descuento es igual a lo que quiere comprar
    if period_product.service.always_discount?
      amount
    else
      period_product.remaining_amount #Devuelve cero si no puede comprar más
    end
  end

  #Devuelve un integer con los puntos particulares del supplier si es que tiene, y sino devuelve los puntos que tiene el producto.
  def get_points(product, supplier)
    product = supplier.supplier_point_products.detect { |spp| spp.product == product } || product
    product.points
  end

end