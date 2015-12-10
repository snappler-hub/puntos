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
    
  # Select2
  $("select").normalSelect()
  
  # Datepicker
  datepicker_icons = {
    time: 'fa fa-clock-o',
    date: 'fa fa-calendar',
    up: 'fa fa-chevron-up',
    down: 'fa fa-chevron-down',
    previous: 'fa fa-chevron-left',
    next: 'fa fa-chevron-right',
    today: 'fa fa-bullseye',
    clear: 'fa fa-trash',
    close: 'fa fa-remove'
  }
  
  $('.datepicker').datetimepicker({icons: datepicker_icons, format: 'YY-mm-dd', locale: 'es'});

  # Reactivo eventos de AdminLTE porque se pierden con turbolinks
  $.AdminLTE.layout.activate()
  $.AdminLTE.tree('.sidebar');

$(document).on "page:change", ->
  App.init()
