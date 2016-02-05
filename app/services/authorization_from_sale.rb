class AuthorizationFromSale

  def initialize(sale, seller)
    @client = sale.client
    @sale_products = sale.sale_products
    @seller = seller
    @supplier = seller.supplier
    @message = {}
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
        @message[Const::STATUS_ERROR] = ['El cliente debe aceptar los términos de uso para poder operar en el sistema.']
      else
        @status = Const::STATUS_OK
        @message[Const::STATUS_WARNING] = []
      end
    else
      @status = Const::STATUS_ERROR
      @message[Const::STATUS_ERROR] = ['El vendedor no tiene permisos para operar ya que su prestador no está activo.']
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

      # Productos con descuentos
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

  # Si el pfpc existe y está activo, devuelvo el período actual
  def period_product(product)
    pfpc = @client.pfpc_services.detect { |pfpc| pfpc.products.include?(product) }
    if pfpc.present? && pfpc.available?
      pfpc.last_period.period_products.detect { |pp| pp.product == product }
    else

      warning_msg = 'El cliente no posee ningún pfpc o período activo.'
      unless @message[Const::STATUS_WARNING].include? warning_msg
        @status = Const::STATUS_WARNING
        @message[Const::STATUS_WARNING] << warning_msg
      end
      nil
    end
  end

  # Porcentaje de descuento para un producto
  def discount(product)
    vademecum = @client.vademecums.detect { |vademecum| vademecum.products.include?(product) }
    if vademecum.present? && @supplier.vademecums.include?(vademecum)
      vademecum.discount(product)
    else
      warning_msg = 'No se encontró un vademecum, por lo que no se aplicarán descuentos.'
      unless @message[Const::STATUS_WARNING].include? warning_msg
        @status = Const::STATUS_WARNING
        @message[Const::STATUS_WARNING] << warning_msg
      end
      0
    end
  end

  # Devuelve array con dos valores: la cant. a la que corresponde aplicar dto y cant. a la que no
  def get_amount_with_and_without_discount(period_product, amount)
    with_discount = 0
    without_discount = amount
    unless period_product.nil?
      remaining = get_remaining_amount(period_product, amount)
      if remaining >= amount
        with_discount = amount
      else
        with_discount = remaining
        without_discount = amount - remaining
      end
    end

    [with_discount, without_discount]
  end

  # Devuelve cantidad disponible
  def get_remaining_amount(period_product, amount)
    #Si en el pfpc está marcada la opción de descontar siempre, la cantidad con descuento es igual a lo que quiere comprar
    if period_product.service.always_discount?
      amount
    else
      period_product.remaining_amount #Devuelve cero si no puede comprar más
    end
  end

  # Producto con descuento aplicado
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

  # Calcula puntos para el producto
  def calculate_points(sale_product)
    if @client.has_points_service? && @supplier.clients_get_points?
      @points += (sale_product.amount * get_points(sale_product.product, @supplier))
    else
      warning_msg = 'El cliente no posee un servicio de puntos activo o el prestador no otorga puntos.'
      unless @message[Const::STATUS_WARNING].include? warning_msg
        @message[Const::STATUS_WARNING] << warning_msg
      end
    end
  end

  # Devuelve un integer con los puntos particulares del supplier si es que tiene, y sino devuelve los puntos que tiene el producto.
  def get_points(product, supplier)
    product = supplier.supplier_point_products.detect { |spp| spp.product == product } || product
    product.points
  end

end