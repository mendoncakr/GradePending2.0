function initialize() {
  var mapOptions = {
    center: new google.maps.LatLng(40.766579, -73.9783445),
    zoom: 14
  };

  var layer = new google.maps.FusionTablesLayer({
    query: {
      select: 'name',
	from: '1Tb6rqCR-YqIrvfJ07wIkH0-QFnE26b3U3hriuYkq'
    }
  });
		
  var map = new google.maps.Map(document.getElementById("map-canvas"),
    mapOptions);
    layer.setMap(map);

    layer.enableMapTips({
      select: "'name'", 
      from: '1Tb6rqCR-YqIrvfJ07wIkH0-QFnE26b3U3hriuYkq',
      geometryColumn: 'latitude', 
      suppressMapTips: false, 
      delay: 200, 
      tolerance: 8,
      key: 'AIzaSyBhUWJ1yNQ8jFdmSGBUjvn7ol2zB_nkdtI'
    });
}

$(function() {

	$(document).one("load", function(){ namesAjax(); })
	getCoords();
	
  // initialize();
});