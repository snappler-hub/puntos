class CardLoader

  def initialize(query)
    @query = query
    @errors = []
  end

  def call
    # Create Stuff
  end

  def valid_input?
    if @query.is_a?(Array)
      return true if @query.all?{|x| x.is_a?(Hash) && x[:number].present?}
      @errors << 'Las tarjetas deben tener formato válido.'
    else
      @errors << 'Debe ser un arreglo: [{number: "123456"}]'
    end
    false
  end

  def errors
    @errors
  end

end