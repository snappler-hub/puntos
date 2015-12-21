class App.SupplierForm
  
  constructor: () ->
    @bindEvents()
    @bindSelects()
    
  # Binding de Eventos
  bindEvents: () ->
    that = @
    
    $('#js-supplier-point-products').on 'cocoon:after-insert', (e, insertedItem) ->
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
  return unless $(".suppliers.new").length > 0 || $(".suppliers.edit").length > 0
  supplierForm = new App.SupplierForm()