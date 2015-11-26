class App.RewardForm
  
  constructor: () ->
    @bindEvents()
    
  # Binding de Eventos
  bindEvents: () ->
    that = @
    $("#reward_service_types").normalSelect()
    
		$('.item-image').on 'click', ->
		  item = $(this).parent()
		  if item.hasClass('open')
		    item.removeClass 'open'
		    item.find('.full-description').hide()
		  else
		    item.addClass 'open'
		    item.find('.full-description').fadeIn()
		  return
  

$(document).on "page:change", ->
  rewardForm = new App.RewardForm()


