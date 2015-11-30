class App.RewardForm
  
  constructor: () ->
    @bindEvents()
    
  # Binding de Eventos
  bindEvents: () ->
    that = @
    $("#reward_service_types").normalSelect()
    
		$('.reward-info').on 'click', ->
		  item = $(this).parent().parent()
		  if item.hasClass('open')
		    item.removeClass 'open'
		    item.find('.full-description').hide()
		  else
		    item.addClass 'open'
		    item.find('.full-description').fadeIn()
		  return
  
		$(document).on 'click', '.reward_shop_cart_control a', ->
		  $('.reward_shop_cart_control a').attr 'disabled', 'disabled'
		  $(this).parent().prepend '<i class="fa fa-2x text-gray fa-cog fa-spin"></i>'
		  return



$(document).on "page:change", ->
  rewardForm = new App.RewardForm()

