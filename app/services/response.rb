class Response
  
  attr_accessor :errors, :warnings, :status
  
  def initialize
    @errors = []
    @warnings = []
    @status = Const::STATUS_OK
  end
  
  def add_error(message)
    @errors << message unless @errors.include?(message)
    @status = Const::STATUS_ERROR
  end
  
  def add_warning(message)
    @warnings << message unless @warnings.include?(message)
    @status = Const::STATUS_WARNING unless (@status == Const::STATUS_ERROR)
  end
  
  def ok?
    @status == Const::STATUS_OK || @status == Const::STATUS_WARNING
  end
  
  def message
    unless @errors.empty?
      @errors
    else
      @warnings
    end
  end
  
end
    