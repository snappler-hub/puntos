class App.ProductList

  constructor: () ->
    @bindEvents()

  # Binding de Eventos
  bindEvents: () ->
    $("[data-behavior~=searchLaboratory]").ajaxSelect()
    $("[data-behavior~=searchDrug]").ajaxSelect()

class App.BatchProduct

  constructor: () ->
    @bindEvents()

  # Binding de Eventos
  bindEvents: () ->
    $("[data-behavior~=searchLaboratory]").ajaxSelect()


$(document).on "page:change", ->
  saleForm = new App.ProductList()
  batchProduct = new App.BatchProduct() unless $(".products.new_batch_update").length == 0
