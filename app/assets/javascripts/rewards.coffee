class App.RewardForm
 

$(document).on "page:change", ->
  rewardForm = new App.RewardForm()

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
  ready()
