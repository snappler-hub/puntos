class App.ServiceForm
  
  constructor: () ->
    @vademecum = $('#js-vademecumField').val()
    @bindEvents()
    
  # Binding de Eventos
  bindEvents: () ->
    that = @
    
    $("[data-behavior~=searchProduct]").ajaxSelect()
    
    $('#js-vademecumField').change (e) =>
      # Si no tiene productos no hago nada
      return false unless @hasProducts()
      
      target = e.currentTarget
      if confirm 'Se borrarán los productos asociados al servicio. ¿Realmente desea cambiar le vademecum?'
        @deleteProducts()
        that.vademecum = $(target).val
      else
        $(target).val(@vademecum)
  
  # True si el servicio tiene productos
  hasProducts: () ->
    $('.product_pfpcs > .nested-fields:visible').length > 0
  
  # Elimina todos los productos. Lo hace disparando el click en 
  # el botón elimnar de cada producto con cocoon :)
  deleteProducts: () ->
    $('.remove_fields').trigger('click')
  

$(document).on "page:change", ->
  return unless $(".services.new").length > 0 || $(".services.edit").length > 0
  serviceForm = new App.ServiceForm()
