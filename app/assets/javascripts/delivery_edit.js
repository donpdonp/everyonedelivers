function formvalidation(event) {
  if($('#from_latitude').val().length > 0) {
    if($('#to_latitude').val().length > 0) {
      // Both points are verified. compute the distance
      p1 = new google.maps.LatLng($('#from_latitude').val(),$('#from_longitude').val());
      p2 = new google.maps.LatLng($('#to_latitude').val(),$('#to_longitude').val());
      $('#delivery_start_end_distance').val(""+distanceBetweenPoints(p1,p2));
      return;
    } else {
      invalidate_to();
      alert("Please correct the To address.");
    }
  } else {
    invalidate_from();
    alert("Please correct the From address.");
  }
  return false;
}

function invalidate_from() {
  $('#from_latitude').val("");
  $('#from_longitude').val("");
  /*$('#from_address_msg').html("Validating.");*/
  $('#from_address_label').addClass('error');
}

function invalidate_to() {
  $('#to_latitude').val("");
  $('#to_longitude').val("");
  /*$('#to_address_msg').html("Validating.")*/
  $('#to_address_label').addClass('error');
}

function validate_from(latlng) {
  $('#from_address_map').html(static_map(latlng,150,70,15));
  $('#from_address_label').removeClass('error');
}

function validate_to(latlng) {
  $('#to_address_map').html(static_map(latlng,150,70,15));
  $('#to_address_label').removeClass('error');
}

function prevalidate_from() {
  var lat = $('#from_latitude').val();
  var lng = $('#from_longitude').val();
  if(lat.length > 0) {
    var latlng = new google.maps.LatLng(lat,lng);
    validate_from(latlng);
  }
}

function prevalidate_to() {
  var lat = $('#to_latitude').val();
  var lng = $('#to_longitude').val();
  if(lat.length > 0) {
    var latlng = new google.maps.LatLng(lat,lng);
    validate_to(latlng);
  }
}

function geocallback_from(results, status) {
  if(status == "OK") {
    var gLatLng = results[0].geometry.location;
    $('#from_latitude').val(""+gLatLng.lat());
    $('#from_longitude').val(""+gLatLng.lng());
    validate_from(gLatLng);
  } else {
    invalidate_from();
  }
}

function geocallback_to(results, status) {
  if(status == "OK") {
    var gLatLng = results[0].geometry.location;
    $('#to_latitude').val(""+gLatLng.lat());
    $('#to_longitude').val(""+gLatLng.lng());
    validate_to(gLatLng);
  } else {
    invalidate_to();
  }
}

function static_map(gLatLng, h, w, zoom) {
  var map_url = "<img src=\"http://maps.google.com/staticmap?center="+
        gLatLng.lat()+","+gLatLng.lng()+"&zoom="+zoom+"&size="+h+"x"+w+
        "&sensor=false&markers="+gLatLng.lat()+","+gLatLng.lng()+"\">";
  console.log(map_url)
  return map_url;
}

function address_from_validate_click(event) {
  var geocoder = new google.maps.Geocoder();
  var request = { address : $('#from_address').val() }
  geocoder.geocode(request, geocallback_from); 
  event.preventDefault();
}

function address_to_validate_click(event) {
  var geocoder = new google.maps.Geocoder();
  var request = { address : $('#to_address').val() }
  geocoder.geocode(request, geocallback_to); 
  event.preventDefault();
}

function distanceBetweenPoints(p1, p2) {
  if (!p1 || !p2) {
    return 0;
  }

  var R = 6371000; // Radius of the Earth in m
  var dLat = (p2.lat() - p1.lat()) * Math.PI / 180;
  var dLon = (p2.lng() - p1.lng()) * Math.PI / 180;
  var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(p1.lat() * Math.PI / 180) * Math.cos(p2.lat() * Math.PI / 180) *
    Math.sin(dLon / 2) * Math.sin(dLon / 2);
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  var d = R * c;
  return d;
}


function setup() {
  $('#from_address').blur(address_from_validate_click)
  /*$('#from_address_validate').click(address_from_validate_click);*/
  $('#to_address').blur(address_to_validate_click)
  /*$('#to_address_validate').click(address_to_validate_click);*/
  $('.edit_delivery').submit(formvalidation);
  $('#from_address').change(invalidate_from);
  $('#to_address').change(invalidate_to);
  prevalidate_from(); 
  prevalidate_to();
}


