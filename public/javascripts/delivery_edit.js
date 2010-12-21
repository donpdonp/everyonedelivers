function formvalidation(event) {
  if(!$('from_latitude').value.blank()) {
    if(!$('to_latitude').value.blank()) {
      // Both points are verified. compute the distance
      p1 = new GLatLng($('from_latitude').value,$('from_longitude').value);
      p2 = new GLatLng($('to_latitude').value,$('to_longitude').value);
      distance = p1.distanceFrom(p2);
      $('delivery_start_end_distance').value = ""+distance;
      return;
    } else {
      invalidate_to();
      alert("Please correct the To address.");
    }
  } else {
    invalidate_from();
    alert("Please correct the From address.");
  }
  event.stop();
}

function invalidate_from() {
  $('from_latitude').value = "";
  $('from_longitude').value = "";
  $('from_address_msg').innerHTML = "Validation needed.";
  $('from_address_label').addClassName('error');
}

function invalidate_to() {
  $('to_latitude').value = "";
  $('to_longitude').value = "";
  $('to_address_msg').innerHTML = "Validation needed.";
  $('to_address_label').addClassName('error');
}

function validate_from(latlng) {
  $('from_address_msg').innerHTML = "Address OK. "+static_map(latlng,150,70,15);
  $('from_address_label').removeClassName('error');
}

function validate_to(latlng) {
  $('to_address_msg').innerHTML = "Address OK. "+static_map(latlng,150,70,15);
  $('to_address_label').removeClassName('error');
}

function prevalidate_from() {
  var lat = $('from_latitude').value;
  var lng = $('from_longitude').value;
  if(!lat.blank()) {
    validate_from();
  }
}

function prevalidate_to() {
  var lat = $('to_latitude').value;
  var lng = $('to_longitude').value;
  if(!lat.blank()) {
    var latlng = new google.maps.LatLng(lat,lng);
    validate_to(latlng);
  }
}

function geocallback_from(results, status) {
  if(status == "OK") {
    var gLatLng = results[0].geometry.location;
    $('from_latitude').value = ""+gLatLng.lat();
    $('from_longitude').value = ""+gLatLng.lng();
    validate_from(gLatLng);
  } else {
    invalidate_from();
  }
}

function geocallback_to(results, status) {
  if(status == "OK") {
    var gLatLng = results[0].geometry.location;
    $('to_latitude').value = ""+gLatLng.lat();
    $('to_longitude').value = ""+gLatLng.lng();
    validate_to(gLatLng);
  } else {
    invalidate_to();
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
  $('from_address').observe('change', invalidate_from);
  $('to_address').observe('change', invalidate_to);
  prevalidate_from(); 
  prevalidate_to();
}

document.observe("dom:loaded", setup); 
