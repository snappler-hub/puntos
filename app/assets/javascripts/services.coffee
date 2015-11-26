class App.ServiceForm
  
  constructor: () ->
    @vademecum = $('#js-vademecumField').val()
    @bindEvents()
    @bindSelects()
    
  # Binding de Eventos
  bindEvents: () ->
    that = @
    
    $('#js-productPfpcs').on 'cocoon:after-insert', (e, insertedItem) ->
      that.bindSelects(insertedItem)
    
    $('#js-vademecumField').change (e) =>
      # Si no tiene productos no hago nada
      return false unless @hasProducts()
      
      target = e.currentTarget
      if confirm 'Se borrarán los productos asociados al servicio. ¿Realmente desea cambiar le vademecum?'
        @deleteProducts()
        that.vademecum = $(target).val
      else
        $(target).val(@vademecum)
  
  # Binding evento de select2 de productos
  bindSelects: (parent) ->
    elements = if (parent) then parent.find("[data-behavior~=searchProduct]") else $("[data-behavior~=searchProduct]")
    elements.ajaxSelect
      selectData: (term, page) ->
        query: term
        page: page
        limit: 10
        vademecum_id: $('#js-vademecumField').val()
  
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
