window.App ||= {}


App.initializeAutocomplete = (parent)->
  if parent
    selects = parent.find('.select2')
  else
    selects = $('.select2')
  selects.each ((_this) ->
    (i, e) ->
      options = undefined
      select = undefined
      select = $(e)
      saved = select.data('saved')
      options =
        placeholder: select.data('placeholder')
        formatNoMatches: 'No hay resultados'
      if select.data('selectformat')
        options.formatResult = eval(select.data('selectformat'))
      if select.hasClass('ajax')
        options.ajax =
          url: select.data('source')
          cache: true
          dataType: 'json'
          data: (term, page) ->
            {
              q: term
              page: page
              per: 25
            }
          results: (data, page) ->
            { results: data.resources }

        options.initSelection = (element, callback) ->
          if saved
            data = 
              id: element.id
              text: saved
            callback data
          return
      result = select.select2(options)
      return
  )(this)
  return



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
  

$(document).on "page:change", ->
  App.init()