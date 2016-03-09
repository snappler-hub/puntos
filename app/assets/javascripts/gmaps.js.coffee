bounds = undefined

geocoder = new (google.maps.Geocoder)
selectedMapPopup = undefined

App.Map =
  map: undefined
  marker: undefined
  map_editable: true
  selected: undefined

  placeMarkers: (markers)->
    for m in markers
      latLng = new (google.maps.LatLng)(m[1], m[2])
      App.Map.placeStaticMarker latLng, m[0], m[3]

  initMap: (map_id, marker_latitude, marker_longitude) ->
    App.Map.buildMap(map_id, marker_latitude, marker_longitude)

  buildMap: (map_id, marker_latitude, marker_longitude, create_marker=true) ->
    latitude = marker_latitude or -34.604
    longitude = marker_longitude or -58.382
    bounds = new (google.maps.LatLngBounds)
    latlng = new (google.maps.LatLng)(latitude, longitude)
    myOptions =
      scrollwheel: false
      zoom: 15
      center: latlng
      mapTypeId: google.maps.MapTypeId.ROADMAP
    App.Map.map = new (google.maps.Map)(document.getElementById(map_id), myOptions)

    # Si se seteó marker_latitude y marker_longitude se muestra un marcador
    if create_marker && marker_latitude and marker_longitude
      App.Map.placeMarker new (google.maps.LatLng)(marker_latitude, marker_longitude)

    google.maps.event.addListener App.Map.map, 'mouseout', (event) ->
      @setOptions scrollwheel: false
      return
    google.maps.event.addListener App.Map.map, 'click', (event) ->
      @setOptions scrollwheel: true
      return

    if App.Map.map_editable
      # Click en el mapa
      google.maps.event.addListener App.Map.map, 'click', (event) ->
        App.Map.placeMarker event.latLng
        App.Map.geocodePoint event.latLng, (data) ->
          $('#address').val data
          return
        return
      google.maps.event.addListener App.Map.map, 'drag', (event) ->
        if event
          App.Map.placeMarker event.latLng
        return

      # Escribe una dirección
      $('#address').keyup ->
        geocoder.geocode { address: $('#address').val() }, (locResult) ->
          if locResult != null and typeof locResult[0] != 'undefined'
            lat = locResult[0].geometry.location.lat()
            lng = locResult[0].geometry.location.lng()
            latLng = new (google.maps.LatLng)(lat, lng)
            bounds.extend latLng
            App.Map.map.fitBounds bounds
            App.Map.placeMarker latLng
            App.Map.map.setZoom 12
            App.Map.map.setCenter latLng
          return
        return

    if $('#js-suppliersMap').length > 0
      App.Map.getSuppliersInBounds()

    return App.Map.map

  # Obtengo una dirección formateada a partir de latitud y longitud
  geocodePoint: (latlng, callback) ->
    full_address = ''
    geocoder.geocode { 'latLng': latlng }, (responses) ->
      if responses and responses.length > 0
        full_address = responses[0].formatted_address
      callback full_address
    return

  # Pone un marcador en el mapa
  placeMarker: (location) ->
    if App.Map.marker
      App.Map.marker.setPosition location
    else
      App.Map.marker = new (google.maps.Marker)(
        position: location
        map: App.Map.map
        draggable: true)
    App.Map.populateInputs location
    return

  # Pone un marcador estático en el mapa
  # este marcador no se puede mover
  placeStaticMarker: (location, info, premium=false) ->
    markerInfo = info || ''
    staticMarker = new (google.maps.Marker)(
      position: location
      map: App.Map.map,
      clickable: true
      )
    info = new (google.maps.InfoWindow)(content: markerInfo)
    google.maps.event.addListener staticMarker, 'click', ->
      info.open App.Map.map, staticMarker
      App.Map.selected = info
      return

    return

  # Setea los inputs de latitud y longitud
  populateInputs: (pos) ->
    $('#latitude').val pos.lat()
    $('#longitude').val pos.lng()
    return

  set_map_center: (lat, long) ->
    App.Map.map.setCenter new (google.maps.LatLng)(lat, long)

  # Obtiene la posición actual del usuario
  initMapInCurrentPosition: ->
    App.Map.buildMap('map')
    if navigator.geolocation
      options =
        enableHighAccuracy: true
        timeout: 2000
        maximumAge: 0
      navigator.geolocation.getCurrentPosition App.Map.current_position_success, App.Map.current_position_error, options

  current_position_success: (position)->
    App.Map.map.setCenter new (google.maps.LatLng)(position.coords.latitude, position.coords.longitude)

  current_position_error: (error)->
    switch error.code
      when error.PERMISSION_DENIED
        alert 'Acceso denegado para obtener la posición actual.'
      when error.POSITION_UNAVAILABLE
        alert 'La información de geolocalización no se encuentra disponible.'
      when error.TIMEOUT
        alert 'La solicitud para obtener la posición actual ha demorado demasiado.'
      when error.UNKNOWN_ERROR
        alert 'Error desconocido al obtener la posición actual.'
    false

  closePopup: ->
    App.Map.selected.close()

  # Mapa de suppliers
  getSuppliersInBounds: ->
    google.maps.event.addListener App.Map.map, 'idle', ->
      bounds = App.Map.map.getBounds()
      if true
        ne = bounds.getNorthEast()
        sw = bounds.getSouthWest()
        data =
          sw: [
            sw.lat()
            sw.lng()
          ]
          ne: [
            ne.lat()
            ne.lng()
          ]
        $.ajax
         url: "/suppliers/list_for_map"
         data: data


$(document).on "page:change", ->
  $('.js-map').each ->
    if $(@).data('position') == 'current'
      App.Map.initMapInCurrentPosition($(@).attr('id'))
    else
      App.Map.buildMap($(@).attr('id'), $(@).data('latitude'), $(@).data('longitude'))