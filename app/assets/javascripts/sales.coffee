class App.SaleForm
  
  constructor: () ->
    @bindEvents()
    @bindProductSelect()
    $("[data-behavior='searchClient']").select2('focus')
    $("[data-behavior~=searchHealthInsurance]").ajaxSelect()
    $("[data-behavior~=searchCoinsurance]").ajaxSelect()
    
  # Binding de Eventos
  bindEvents: () ->
    that = @
    
    $('#js-productSales').on 'cocoon:after-insert', (e, insertedItem) ->
      that.bindProductSelect(insertedItem)
  
  # Binding evento de select2 de productos
  bindProductSelect: (parent) ->
    elements = if (parent) then parent.find("[data-behavior~=searchProduct]") else $("[data-behavior~=searchProduct]")
    elements.ajaxSelect
      format_name: (record) ->
        "#{record.name} (#{Utilities.formatMoney(record.price)})"
    elements.on 'change', (e)->
      input = $(e.target).closest('.nested-fields').find('.js-cost')
      input.val(e.added.price)
      
    
    $("[data-behavior='searchClient']").on 'change', =>
      @onClientSelect()
  
  onClientSelect: ->
    # Si no hay productos todavía simulo el click en Agregar Producto
    return false unless $('.nested-fields').length == 0
    $('.add_fields').trigger 'click'
      

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