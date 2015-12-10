class App.RewardOrderForm
  

    
$(document).on "page:change", ->
  rewardOrderForm = new App.RewardOrderForm()

ready = ->
  $("[data-behavior~=searchUser]").ajaxSelect()
    

$(document).ready(ready)
$(document).on('page:load', ready)
    