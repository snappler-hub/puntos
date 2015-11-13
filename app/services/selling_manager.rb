class SellingManager

  def initialize(query)
    @query = query
    @errors = []
  end

  def update
    # TODO: Impactar ventas
  end

  def authorize
    # TODO: Autorizar ventas
  end

  def valid_input?
    if @query.is_a?(Hash)
      return true
    else
      @errors << 'Consulta mal formada.'
    end
    false
  end

  def errors
    @errors
  end

end