jQuery.fn.ajaxSelect = (options) ->
  url = $(this).data('url')

  defaults =
    placeholder: "Realizar una búsqueda"
    formatNoMatches: 'No hay resultados'
    formatter: (record) ->
      record.full_text || record.name
    result_formatter: (record, container, query, escapeMarkup) ->
      markup = []
      text = settings.format_name(record)
      Select2.util.markMatch(text, query.term, markup, escapeMarkup)
      markup = markup.join("")
      markup = "<div class='select2-main-text'> #{markup} </div>"
      if record.extra
        markup += settings.format_extra(record)
        
      return markup
    format_name: (record) ->
      record.full_text || record.name
    format_extra: (record) ->
      return "<small class='select2-extra-text'> #{record.extra} </small>" 
      
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
    formatResult: settings.result_formatter
    formatSelection: settings.formatter


jQuery.fn.normalSelect = (options) ->
  url = $(this).data('url')

  defaults =
    allow_clear: true

  settings = $.extend(defaults, options)

  this.select2
    placeholder: settings.placeholder
    allowClear: settings.allow_clear
