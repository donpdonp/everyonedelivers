function schedule_submit(event) {
  console.log("submit!");
  if($('#gmaplat').val().length > 0 &&
     $('#gmaplng').val().length > 0 &&
     $('#street1_field').val().length > 0 &&
     $('#street2_field').val().length > 0 ) {
    return true;
  } else {
    alert('Please position the map marker');
    return false;  
  }
}