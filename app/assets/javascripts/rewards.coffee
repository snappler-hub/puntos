class App.RewardMap
  
  constructor: () ->
    @latitude = $('#js-supplierLat').val()
    @longitude = $('#js-supplierLong').val()
    @initMap()
    
  initMap: () ->  
    App.Map.map_editable = false
    @map = App.Map.buildMap('js-suppliersMap', @latitude, @longitude, false)
      
  selectSupplier: (supplier_id, supplier_name) ->
    $('#js-supplierId').val(supplier_id)
    $('#js-supplierName').html(supplier_name)
    App.Map.closePopup()
    $('#js-supplierName').text(supplier_name).clearQueue().queue((next) ->
      $(this).addClass 'alert-warning'
      next()
      return
    ).delay(600).queue (next) ->
      $(this).removeClass 'alert-warning'
      next()
      return
 

ready = ->
  ### Hacer click en cambio de stock abre el modal ###
	$(document).on 'click', '.js-down_stock', (e) ->
	  e.preventDefault()
	  $('#modal_one').modal 'show'
	  $.getScript '/rewards/' + $(this).data('id') + '/down_stock'
	  return

	### Hacer click en cambio de stock abre el modal ###
	$(document).on 'click', '.js-up_stock', (e) ->
	  e.preventDefault()
	  $('#modal_one').modal 'show'
	  $.getScript '/rewards/' + $(this).data('id') + '/up_stock'
	  return

    

$(document).on "page:change", ->
  App.rewardMap = new App.RewardMap() unless $(".shopping_cart_rewards.shoping_cart").length == 0
  ready()
