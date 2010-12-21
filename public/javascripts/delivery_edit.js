function formvalidation(event) {
  if($('from_latitude').value.length > 0) {
    if($('to_latitude').value.length > 0) {
      // Both points are verified. compute the distance
      p1 = new GLatLng($('from_latitude').value,$('from_longitude').value);
      p2 = new GLatLng($('to_latitude').value,$('to_longitude').value);
      distance = p1.distanceFrom(p2);
      $('delivery_start_end_distance').value = ""+distance;
      return true;
    } else {
      alert("Validate the To address");
    }
  } else {
    alert("Validate the From address");
  }
  event.stop();
}

function invalidate_from() {
  $('from_latitude').value = "";
  $('from_address_msg').innerHTML = "Validation needed.";
}

function invalidate_to() {
  $('to_latitude').value = "";
  $('to_address_msg').innerHTML = "Validation needed.";
}

function prevalidate_from() {
  var lat = $('from_latitude').value;
  var lng = $('from_longitude').value;
  if(!lat.blank()) {
    $('from_address_msg').innerHTML = "Address OK. "+static_map(new GLatLng(lat,lng),150,70,15);
  }
}

function prevalidate_to() {
  var lat = $('to_latitude').value;
  var lng = $('to_longitude').value;
  if(!lat.blank()) {
    $('to_address_msg').innerHTML = "Address OK. "+static_map(new GLatLng(lat,lng),150,70,15);
  }
}

function geocallback_from(results, status) {
  if(status == "OK") {
    var gLatLng = results[0].geometry.location;
    $('from_address_msg').innerHTML = "Address OK. "+static_map(gLatLng,150,70,15);
    $('from_latitude').value = ""+gLatLng.lat();
    $('from_longitude').value = ""+gLatLng.lng();
  } else {
    $('from_address_msg').innerHTML = "Google does not recognize this address. Please fix.";
    $('from_latitude').value = "";
    $('from_longitude').value = "";
  }
}

function geocallback_to(results, status) {
  if(status == "OK") {
    var gLatLng = results[0].geometry.location;
    $('to_address_msg').innerHTML = "Address OK. "+static_map(gLatLng,150,70,15);
    $('to_latitude').value = ""+gLatLng.lat();
    $('to_longitude').value = ""+gLatLng.lng();
  } else {
    $('to_address_msg').innerHTML = "Google does not recognize this address. Please fix.";
    $('to_latitude').value = "";
    $('to_longitude').value = "";
  }
}

function static_map(gLatLng, h, w, zoom) {
  return "<img src=\"http://maps.google.com/staticmap?center="+gLatLng.lat()+","+gLatLng.lng()+"&zoom="+zoom+"&size="+h+"x"+w+"&sensor=false&markers="+gLatLng.lat()+","+gLatLng.lng()+"\">";
}

function address_from_validate_click(event) {
  var geocoder = new google.maps.Geocoder();
  var request = { address : $('from_address').value }
  geocoder.geocode(request, geocallback_from); 
  event.stop();
}

function address_to_validate_click(event) {
  var geocoder = new google.maps.Geocoder();
  var request = { address : $('to_address').value }
  geocoder.geocode(request, geocallback_to); 
  event.stop();
}

function setup() {
  $('from_address_validate').observe('click', address_from_validate_click);
  $('to_address_validate').observe('click', address_to_validate_click);
  $$('.edit_delivery')[0].observe('submit', formvalidation);
  prevalidate_from(); 
  prevalidate_to();
}

document.observe("dom:loaded", setup); 
