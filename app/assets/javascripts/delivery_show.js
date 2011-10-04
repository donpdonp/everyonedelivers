  function mapinitialize(start_lat, start_long, end_lat, end_long, units) {

    var start, end, sw, ne;
    start = new google.maps.LatLng(start_lat, start_long);
    end = new google.maps.LatLng(end_lat, end_long);
    var bounds = new google.maps.LatLngBounds();
    bounds.extend(start);
    bounds.extend(end);

    var map = new google.maps.Map(document.getElementById("gmap"),
                                  {mapTypeId: google.maps.MapTypeId.ROADMAP,
                                   center: bounds.getCenter(),
                                   zoom: 12});
    // this could be avoided if the zoom level could be calculated
    map.fitBounds(bounds);

    var marker_start = new google.maps.Marker({position:start});
    marker_start.setMap(map);
    var marker_end = new google.maps.Marker({position:end});
    marker_end.setMap(map);
     

    var directions = new google.maps.DirectionsService();
    var request = { origin : start,
                    destination : end,
                    travelMode : google.maps.DirectionsTravelMode.DRIVING,
                    unitSystem: units };
    directions.route(request, show_directions_callback_builder(map));
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
