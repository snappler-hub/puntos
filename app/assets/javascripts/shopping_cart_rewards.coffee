class App.ShoppingCartRewardForm
  
  constructor: () ->
    @bindEvents()
    
  # Binding de Eventos
  bindEvents: () ->
    that = @
    $("#reward_service_types").normalSelect()
    
		$(document).on 'click', '.reward-info', ->
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

App.ShoppingCartReward = 
	calculate_totals: ->
		total_amount = 0
		total_need_points_subtotal = 0
		$('.shop_cart_item .reward_amount_container').each ->
		  total_amount += parseInt($(this).html() or 0)
		  return
		$('#total_amount').html total_amount
		total_need_points_subtotal = 0
		$('.shop_cart_item .reward_need_points_subtotal_container').each ->
		  total_need_points_subtotal += parseInt($(this).html() or 0)
		  return
		$('#total_need_points_subtotal').html total_need_points_subtotal

		if total_amount == 0
  		window.location.href = '/shopping_cart_rewards/list'




$(document).on "page:change", ->
  shoppingCartRewardForm = new App.ShoppingCartRewardForm()



