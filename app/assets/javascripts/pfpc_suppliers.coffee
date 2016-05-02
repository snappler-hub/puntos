class App.PfpcServiceForm
  
  constructor: () ->
    @vademecum = $('#js-vademecumField').val()
    @bindEvents()
    @bindSelects()
    
  # Binding de Eventos
  bindEvents: () ->
    that = @
    
    $('#js-pfpcSuppliers').on 'cocoon:after-insert', (e, insertedItem) ->
      that.bindSelects(insertedItem)

    $('#js-vademecumField').change (e) =>
      that.bindDefaultSuppliers()
  
  # Binding evento de select2 de prestadores
  bindSelects: (parent) ->
    elements = if (parent) then parent.find("[data-behavior~=searchSupplier]") else $("[data-behavior~=searchSupplier]")
    elements.ajaxSelect
      selectData: (term, page) ->
        query: term
        page: page
        limit: 10
        vademecum_id: $('#js-vademecumField').val()

  # Precarga los prestadores
  bindDefaultSuppliers: (parent) ->
    @vademecum = $('#js-vademecumField').val()
    $.ajax
      url: "/vademecums/#{@vademecum}/get_suppliers"
        
$(document).on "page:change", ->
  if $(".services.new").length > 0 || $(".services.edit").length > 0
    pfpcServiceForm = new App.PfpcServiceForm()
    