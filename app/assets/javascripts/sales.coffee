class App.SaleForm
  
  constructor: () ->
    @bindEvents()
    @bindSelects()
    
  # Binding de Eventos
  bindEvents: () ->
    that = @
    
    $('#js-productSales').on 'cocoon:after-insert', (e, insertedItem) ->
      that.bindSelects(insertedItem)
  
  # Binding evento de select2 de productos
  bindSelects: (parent) ->
    elements = if (parent) then parent.find("[data-behavior~=searchProduct]") else $("[data-behavior~=searchProduct]")
    elements.ajaxSelect
      selectData: (term, page) ->
        query: term
        page: page
        limit: 10    
    

$(document).on 'click', '#js-clearAuthorizationContnet', ->
    $('#js-authorization').empty()

$(document).on "page:change", ->
  saleForm = new App.SaleForm()

# Select2 de usuario en el form de sale
ready = ->
    $("[data-behavior~=searchClient]").ajaxSelect()

$(document).ready(ready)
$(document).on('page:load', ready)