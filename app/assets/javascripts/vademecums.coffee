class App.VademecumForm
  
  constructor: () ->
    @bindEvents()
    @bindProductSelect()
    @bindSelects()
    
  # Binding de Eventos
  bindEvents: () ->
    that = @
    
    $('#js-vademecum-product-discounts').on 'cocoon:after-insert', (e, insertedItem) ->
      that.bindProductSelect(insertedItem)
      that.bindSelects(insertedItem)
  
  # Binding evento de select2 de productos
  bindProductSelect: (parent) ->
    elements = if (parent) then parent.find("[data-behavior~=searchProduct]") else $("[data-behavior~=searchProduct]")
    elements.ajaxSelect
      selectData: (term, page) ->
        query: term
        page: page
        limit: 10
  
  bindSelects: (parent) ->
    element = if (parent) then parent.find("[data-behavior='searchHealthInsurance']").ajaxSelect() else $("[data-behavior='searchHealthInsurance']")
    element.ajaxSelect()
    element = if (parent) then parent.find("[data-behavior='searchCoinsurance']").ajaxSelect() else $("[data-behavior='searchCoinsurance']")
    element.ajaxSelect()
      
        
$(document).on "page:change", ->
  return unless $(".vademecums.new").length > 0 || $(".vademecums.edit").length > 0
  vademecumForm = new App.VademecumForm()