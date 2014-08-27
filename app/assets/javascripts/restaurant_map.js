function restaurantAjax (callback){
  var id = document.URL.split('/').pop()
  
  $.get ('restaurants/'+id ).done(function (data) {
    callback(data)
  })
}



function initialize(response) {
  var mapOptions = {
    center: new google.maps.LatLng(response.latitude, response.longitude),
    zoom: 15
  };
  var map = new google.maps.Map(document.getElementById("map-canvas2"), mapOptions);
  
}

$(function () {
  restaurantAjax(initialize)
})