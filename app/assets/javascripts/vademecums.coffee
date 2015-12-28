class App.VademecumForm
  
  constructor: () ->
    @bindEvents()
    @bindSelects()
    
  # Binding de Eventos
  bindEvents: () ->
    that = @
    
    $('#js-vademecum-product-discounts').on 'cocoon:after-insert', (e, insertedItem) ->
      that.bindSelects(insertedItem)
  
  # Binding evento de select2 de productos
  bindSelects: (parent) ->
    elements = if (parent) then parent.find("[data-behavior~=searchProduct]") else $("[data-behavior~=searchProduct]")
    elements.ajaxSelect
      selectData: (term, page) ->
        query: term
        page: page
        limit: 10    
        
$(document).on "page:change", ->
  return unless $(".vademecums.new").length > 0 || $(".vademecums.edit").length > 0
  vademecumForm = new App.VademecumForm()