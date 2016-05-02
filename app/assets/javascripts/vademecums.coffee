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

    $("[data-behavior~=searchProduct]").on 'change', (e) =>
      this.onProductChanged(e.added, e)


  bindSelects: (parent) ->
    element = if (parent) then parent.find("[data-behavior='searchHealthInsurance']").ajaxSelect() else $("[data-behavior='searchHealthInsurance']")
    element.ajaxSelect()
    element = if (parent) then parent.find("[data-behavior='searchCoinsurance']").ajaxSelect() else $("[data-behavior='searchCoinsurance']")
    element.ajaxSelect()

  onProductChanged: (product, event) ->
    $(event.target).closest('.row').find('.js-info').remove() # Elimino el anterior
    delete_button = $(event.target).closest('.row').find('.remove_fields')
    title = this.formatExtraTooltip(product)
    $('<span class="info js-info btn btn-default btn-xs" data-html="true" data-toggle="tooltip" title="'+title+'"> <i class="fa fa-info"></i> </span>').insertAfter(delete_button)

  formatExtraTooltip: (product) ->
    "<b>Presentación</b><br> #{product.presentation_form}<br> \
     <b>Laboratorio</b><br> #{product.laboratory}<br> \
     <b>Monodroga</b><br> #{product.drug}<br> \
     <b>Código de barra</b><br> #{product.barcode}"


$(document).on "page:change", ->
  return unless $(".vademecums.new").length > 0 || $(".vademecums.edit").length > 0
  vademecumForm = new App.VademecumForm()
