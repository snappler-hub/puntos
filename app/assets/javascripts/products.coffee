class App.ProductList
  
  constructor: () ->
    @bindEvents()
    
  # Binding de Eventos
  bindEvents: () ->
    $("[data-behavior~=searchLaboratory]").ajaxSelect()
    $("[data-behavior~=searchDrug]").ajaxSelect()
  

$(document).on "page:change", ->
  saleForm = new App.ProductList()