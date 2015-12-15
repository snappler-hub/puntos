window.App ||= {}

App.init = ->
  # Turbolinks progress bar
  Turbolinks.enableProgressBar()

  # Snackbar
  if $('.snackbar-message').length > 0
    $('.snackbar-message').snackbar 'show'


  #  flash_snackbar_render = (flashMessages) ->
  #    $.each flashMessages, (key, value) ->
  #      style = ''
  #      switch key
  #        when 'success'
  #          style = 'callout callout-success'
  #        when 'danger'
  #          style = 'callout callout-danger'
  #        else
  #          style = 'callout'
  #          break
  #      $.snackbar
  #        content: value
  #        style: style
  #        timeout: 10000
  #      return
  #    return


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

  $('.datepicker').datetimepicker({icons: datepicker_icons, format: 'DD-MM-YYYY', locale: 'es'});

  # Reactivo eventos de AdminLTE porque se pierden con turbolinks
  $.AdminLTE.layout.activate()
  $.AdminLTE.tree('.sidebar');


$(document).on "page:load", ->
  App.init()

#$(document).on 'flash:send', (e, flashMessages) ->
#  flash_snackbar_render flashMessages
#  return
