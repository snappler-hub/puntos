class AuthorizationFromSale
  
  attr_accessor :client, :supplier, :response

  def initialize(sale, seller)
    @client = sale.client
    @sale_products = sale.sale_products
    @seller = seller
    @supplier = seller.supplier
    @response = Response.new
    @points = 0
  end

  def authorize
    check_errors
    Authorization.new(
        client: @client,
        seller: @seller,
        products: get_products,
        status: @response.status,
        message: @response.message,
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
      # Productos con descuentos
      discounter = Discounter.new(sale_product, self).call
      products << create_product(sale_product, discounter.discount)

      #Puntos
      calculate_points(sale_product)
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

  # Calcula puntos para el producto
  def calculate_points(sale_product)
    if @client.has_points_service? && @supplier.clients_get_points?
      @points += (sale_product.amount * get_points(sale_product.product, @supplier))
    else
      if @supplier.clients_get_points?
        warning = 'El cliente no posee un servicio de puntos activo.'
      else
        warning = 'El prestador no otorga puntos.'
      end
      @response.add_warning(warning)
    end
  end

  # Devuelve un integer con los puntos particulares del supplier si es que tiene; sino devuelve los puntos del producto.
  def get_points(product, supplier)
    product = supplier.supplier_point_products.detect { |spp| spp.product == product } || product
    product.points
  end

end