window.App ||= {}

App.initSnackbar = ->
  if $('.snackbar-message').length > 0
    $('.snackbar-message').snackbar 'show'
    
# Inicializa los modals con ajax     
App.initModals = (parent) ->
  if parent
    links = parent.find('[data-behavior~=ajax-modal]')
  else
    links = $('[data-behavior~=ajax-modal]')

  links.on 'click', (e)->
    that = this
    e.preventDefault()
    e.stopPropagation()
    $.ajax
      url: this.href
    .done (data)->
      modal = $(that.getAttribute('data-target'))
      modal.addClass(that.getAttribute('data-targetClass'))
      modal.find('.modal-content').html(data)
      modal.modal("show");
    
    return    
    
App.init = ->
  # Turbolinks progress bar
  Turbolinks.enableProgressBar()

  # Snackbar
  App.initSnackbar()
  
  # Ajax Modals
  App.initModals()

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

  $('.sidebar li.active').closest('.treeview').addClass('active')

$(document).on "page:load", ->
  App.init()
  
$(document).on "page:change", ->
  App.initSnackbar()
  App.initModals()
  $("select").normalSelect()