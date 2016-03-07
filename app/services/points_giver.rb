class PointsGiver
  
  attr_accessor :client_points, :seller_points, :response
  
  def initialize(afs)
    @client = afs.client
    @seller = afs.seller
    @supplier = afs.supplier
    @response = afs.response
    @client_points = 0
    @seller_points = 0
  end
  
  def call(sale_product)
    self.calculate_client_points(sale_product)
    self.calculate_seller_points(sale_product)
  end
  
  # Calcula puntos para el cliente
  def calculate_client_points(sale_product)
    if @client.has_points_service? && @supplier.give_points_to_client?
      total = sale_product.amount * sale_product.cost
      points = (total * get_client_points(sale_product.product)) / 100
      sale_product.update(client_points: points) #Cada producto de la autorización tiene que tener su detalle de puntos
      @client_points += points
    else
      if @supplier.give_points_to_client?
        warning = 'El cliente no posee un servicio de puntos activo.'
      else
        warning = 'El prestador no otorga puntos a los clientes.'
      end
      @response.add_warning(warning)
    end
  end

  # Devuelve un integer con los puntos particulares del supplier si es que tiene; sino devuelve los puntos del producto.
  def get_client_points(product)
    product = @supplier.supplier_point_products.detect { |spp| spp.product == product } || product
    product.client_points
  end
  
  # Calcula puntos para el vendedor
  def calculate_seller_points(sale_product)
    if @supplier.give_points_to_seller?
      total = sale_product.amount * sale_product.cost
      product = @supplier.supplier_point_products.detect { |spp| spp.product == sale_product.product } || sale_product.product
      points = (total * product.seller_points) / 100
      sale_product.update(seller_points: points)
      @seller_points += points
    else
      @response.add_warning('El prestador no otorga puntos a los vendedores.')
    end
  end
  
end