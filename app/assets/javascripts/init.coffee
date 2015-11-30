window.App ||= {}

App.init = ->
  # Turbolinks progress bar
  Turbolinks.enableProgressBar()
  
  # Snackbar
  if $('.snackbar-message').length > 0
    $('.snackbar-message').snackbar 'show'
  
  # Sidebar
  $('[data-controlsidebar]').on 'click', ->
    change_layout $(this).data('controlsidebar')
    slide = !AdminLTE.options.controlSidebarOptions.slide
    AdminLTE.options.controlSidebarOptions.slide = slide
    if !slide
      $('.control-sidebar').removeClass 'control-sidebar-open'
    return
    
  # Reactivo eventos de AdminLTE porque se pierden con turbolinks
  $.AdminLTE.layout.activate()
  $.AdminLTE.tree('.sidebar');

$(document).on "page:change", ->
  App.init()
