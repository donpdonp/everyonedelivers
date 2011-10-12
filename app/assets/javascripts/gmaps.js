  function mapinitialize(start_lat, start_long, end_lat, end_long, units) {

    var start = new google.maps.LatLng(start_lat, start_long);
    var bounds = new google.maps.LatLngBounds();
    bounds.extend(start);

    var map = new google.maps.Map(document.getElementById("gmap"),
                                  {mapTypeId: google.maps.MapTypeId.ROADMAP,
                                   center: bounds.getCenter(),
                                   zoom: 12});
    var marker_start = new google.maps.Marker({position:start});
    marker_start.setMap(map);

    if (typeof(end_lat) == "number") {
      var end = new google.maps.LatLng(end_lat, end_long);
      bounds.extend(end);
      map.fitBounds(bounds);

      var marker_end = new google.maps.Marker({position:end});
      marker_end.setMap(map);
       

      var directions = new google.maps.DirectionsService();
      var request = { origin : start,
                      destination : end,
                      travelMode : google.maps.DirectionsTravelMode.DRIVING,
                      unitSystem: units };
      directions.route(request, show_directions_callback_builder(map));
    }
  }

  function show_directions_callback_builder(map) {
    // use a closure to make map a local variable
    return function show_directions(result, status) {
      if(status == "NOT_FOUND") {
        $('#gmaperror').html("Route not found");
      }
      if(status == "OK") {
        renderer = new google.maps.DirectionsRenderer({directions: result,
                                                       suppressMarkers : true});
        renderer.setMap(map);
        $('#travel_distance').html(result.routes[0].legs[0].distance.text)
      }
    }
  }
