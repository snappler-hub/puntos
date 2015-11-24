jQuery.fn.ajaxSelect = (options) ->
  url = $(this).data('url')
  
  defaults =
    placeholder: "Realizar una búsqueda"
    formatNoMatches: 'No hay resultados'
    formatter: (record) ->
      record.name
    allow_clear: true
    selectData: (term, page)->
      query: term
      limit: 10
      page: page

  settings = $.extend(defaults, options)

  this.select2
    initSelection: (elm, callback) ->
      data =
        id: $(elm).data "record-id"
        name: $(elm).data "record-text"
      callback(data)
    placeholder: settings.placeholder
    allowClear: settings.allow_clear
    minimumInputLength: 3
    ajax:
      url: url
      dataType: "jsonp"
      quietMillis: 100
      data: (term, page) ->
        settings.selectData(term, page)
      results: (data, page) ->
        more = (page * 10) < data.total

        results: data.records
        more: more
    formatResult: settings.formatter
    formatSelection: settings.formatter
