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
      format_name: (record) ->
        "#{record.name} (#{Utilities.formatMoney(record.price)})"
      format_extra: (record) ->
        "<small class='select2-extra-text'> \
          #{record.laboratory} <br> \
          #{record.barcode} | #{record.troquel_number}\
        </small>"
    elements.on 'change', (e)->
      input = $(e.target).closest('.nested-fields').find('.js-cost')
      input.val(e.added.price)
    

App.salesListEvents = ->
  $('#js-salesFilter').find("[data-behavior~=filter]").click ->
    $('#js-salesFormFormat').val('html')
    
  $('#js-salesFilter').find("[data-behavior~=export]").click ->
    $('#js-salesFormFormat').val('xlsx')


$(document).on 'click', '#js-clearAuthorizationContnet', ->
    $('#js-authorization').empty()

$(document).on "page:change", ->
  saleForm = new App.SaleForm()
  if $(".sales.index").length > 0 
    App.salesListEvents()
  

# Select2 de usuario en el form de sale
ready = ->
    $("[data-behavior~=searchClient]").ajaxSelect()

$(document).ready(ready)
$(document).on('page:load', ready)