#jQuery.fn.ajaxSelect = (options) ->
#  url = $(this).data('url')
#
#  defaults =
#    placeholder: "Realizar una búsqueda"
#    formatNoMatches: 'No hay resultados'
#    formatter: (record) ->
#      record.name
#    allow_clear: true
#    selectData: (term, page)->
#      query: term
#      limit: 10
#      page: page
#
#  settings = $.extend(defaults, options)
#
#  this.select2
#    initSelection: (elm, callback) ->
#      data =
#        id: $(elm).data "record-id"
#        name: $(elm).data "record-text"
#      callback(data)
#    placeholder: settings.placeholder
#    allowClear: settings.allow_clear
#    minimumInputLength: 3
#    ajax:
#      url: url
#      dataType: "jsonp"
#      quietMillis: 100
#      data: (term, page) ->
#        settings.selectData(term, page)
#      results: (data, page) ->
#        more = (page * 10) < data.total
#
#        results: data.records
#        more: more
#    formatResult: settings.formatter
#    formatSelection: settings.formatter
#
#
#jQuery.fn.normalSelect = (options) ->
#  url = $(this).data('url')
#
#  defaults =
#    allow_clear: true
#
#  settings = $.extend(defaults, options)
#
#  this.select2
#    placeholder: settings.placeholder
#    allowClear: settings.allow_clear
#







console.log 'Initializer: select2'
ready = undefined

ready = ->
  _select2 = $('.select2')
  _select2_ajax = $('.select2_ajax')
  _select2_ajax_client = $('.select2_ajax_client')
  _select2.select2().each ->
    $(this).select2 'destroy'
    return
  _select2_ajax.select2().each ->
    $(this).select2 'destroy'
    return
  _select2_ajax_client.select2().each ->
    $(this).select2 'destroy'
    return
  _select2.select2 language: 'es'
  select2_ajax_conf =
    language: 'es'
    ajax:
      dataType: 'json'
      delay: 250
      data: (params) ->
        {
          q: params.term
          page: params.page
        }
      processResults: (data, page) ->
        { results: data }
      cache: true
    escapeMarkup: (markup) ->
      markup
    minimumInputLength: 1
  select2_ajax_client = jQuery.extend(true, {}, select2_ajax_conf)
  _select2_ajax.select2 select2_ajax_conf
  _select2_ajax_client.select2 select2_ajax_client
  return

$(document).ready ready
$(document).on 'page:load', ready