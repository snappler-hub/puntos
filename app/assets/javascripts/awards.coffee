class App.AwardForm
  
  constructor: () ->
    @bindEvents()
    
  # Binding de Eventos
  bindEvents: () ->
    that = @
    $("#reward_service_types").normalSelect()
    
  

$(document).on "page:change", ->
  awardForm = new App.AwardForm()
