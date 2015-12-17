map = undefined
bounds = undefined
map_editable = true
marker = undefined
geocoder = new (google.maps.Geocoder)

# Map initializer with markers on it
# Markers should be in the form [name, latitude, longitude]
@initMapWithMarkers = (map_id, markers, center_point) ->
  map_editable = false
  latLng
  initMap map_id, center_point[0], center_point[1] unless map
  
  placeMarkers(markers)
  
  if center_point is undefined
    map.setCenter latLng
  else
    map.setCenter new (google.maps.LatLng)(center_point[0], center_point[1])
    
  return
  
@placeMarkers = (markers)->
  for m in markers
    latLng = new (google.maps.LatLng)(m[1], m[2])
    placeStaticMarker latLng, m[0], m[3]

# Map initializer
@initMap = (map_id, marker_latitude, marker_longitude) ->
  buildMap(map_id, marker_latitude, marker_longitude)
     
@buildMap = (map_id, marker_latitude, marker_longitude) ->     
  latitude = marker_latitude or -34.604
  longitude = marker_longitude or -58.382
  bounds = new (google.maps.LatLngBounds)
  latlng = new (google.maps.LatLng)(latitude, longitude)
  myOptions = 
    zoom: 15
    center: latlng
    mapTypeId: google.maps.MapTypeId.ROADMAP
  map = new (google.maps.Map)(document.getElementById(map_id), myOptions)
  
  # Si se seteó marker_latitude y marker_longitude se muestra un marcador
  if marker_latitude and marker_longitude
    placeMarker new (google.maps.LatLng)(marker_latitude, marker_longitude)
    
  if map_editable
    # Click en el mapa
    google.maps.event.addListener map, 'click', (event) ->
      placeMarker event.latLng
      geocodePoint event.latLng, (data) ->
        $('#address').val data
        return
      return
    google.maps.event.addListener map, 'drag', (event) ->
      if event
        placeMarker event.latLng
      return
      
    # Escribe una dirección
    $('#address').keyup ->
      geocoder.geocode { address: $('#address').val() }, (locResult) ->
        if locResult != null and typeof locResult[0] != 'undefined'
          lat = locResult[0].geometry.location.lat()
          lng = locResult[0].geometry.location.lng()
          latLng = new (google.maps.LatLng)(lat, lng)
          bounds.extend latLng
          map.fitBounds bounds
          placeMarker latLng
          map.setZoom 12
          map.setCenter latLng
        return
      return

  return

# Obtengo una dirección formateada a partir de latitud y longitud
geocodePoint = (latlng, callback) ->
  full_address = ''
  geocoder.geocode { 'latLng': latlng }, (responses) ->
    if responses and responses.length > 0
      full_address = responses[0].formatted_address
    callback full_address
  return

# Pone un marcador en el mapa
placeMarker = (location) ->
  if marker
    marker.setPosition location
  else
    marker = new (google.maps.Marker)(
      position: location
      map: map
      draggable: true)
  populateInputs location
  return
  
# Pone un marcador estático en el mapa
# este marcador no se puede mover
placeStaticMarker = (location, info, premium=false) ->
  markerInfo = info || ''
  icon = if premium then '/assets/marker-lupa.png' else 'assets/marker-simple.png'
  staticMarker = new (google.maps.Marker)(
    position: location
    icon: icon
    map: map,
    clickable: true
    )
  info = new (google.maps.InfoWindow)(content: markerInfo)
  google.maps.event.addListener staticMarker, 'click', ->
    info.open map, staticMarker
    return
  
  return

# Setea los inputs de latitud y longitud
populateInputs = (pos) ->
  $('#latitude').val pos.lat()
  $('#longitude').val pos.lng()
  return

@set_map_center = (lat, long) ->
  map.setCenter new (google.maps.LatLng)(lat, long)

# -------------------------
# Obtiene la posición actual del usuario
@initMapInCurrentPosition = ->
  buildMap('map')
  if navigator.geolocation
    options = 
      enableHighAccuracy: true
      timeout: 5000
      maximumAge: 0
    navigator.geolocation.getCurrentPosition current_position_success, current_position_error, options

@current_position_success = (position)->
  map.setCenter new (google.maps.LatLng)(position.coords.latitude, position.coords.longitude)

  
@current_position_error = (error)->
  
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
  
  
$(document).on "page:change", ->
  $('.js-map').each ->
    if $(@).data('position') == 'current'
      initMapInCurrentPosition($(@).attr('id'))
    else
      buildMap($(@).attr('id'), $(@).data('latitude'), $(@).data('longitude'))