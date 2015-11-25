class App.SaleForm
  
  constructor: () ->
    @bindEvents()
    
  # Binding de Eventos
  bindEvents: () ->
    console.log('Entro')
    $("[data-behavior~=searchProduct]").ajaxSelect()

$(document).on 'click', '.add_fields', ->
    saleForm = new App.SaleForm()