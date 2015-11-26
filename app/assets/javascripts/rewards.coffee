class App.RewardForm
  
  constructor: () ->
    @bindEvents()
    
  # Binding de Eventos
  bindEvents: () ->
    that = @
    $("#reward_service_types").normalSelect()
    
    $(".item-image").on 'click', ->
    	$(this).parent().toggleClass('open')
  

$(document).on "page:change", ->
  rewardForm = new App.RewardForm()


