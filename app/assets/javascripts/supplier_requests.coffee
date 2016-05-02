class App.SupplierRequestForm
  
  constructor: () ->
    @bindEvents()
    
  # Binding de Eventos
  bindEvents: () ->
    $("#js-supplierRequestForm").submit ->
      $('select, input').attr('disabled', false)
    
  

$(document).on "page:change", ->
  return false unless $('.supplier_requests.new')
  supplierRequestForm = new App.SupplierRequestForm()
  