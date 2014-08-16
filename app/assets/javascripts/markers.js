var getCoords = function() {
	function initialize() {
		var mapOptions = {
			center: new google.maps.LatLng(40.766579, -73.9783445),
			zoom: 14
		};

		var layer2 = new google.maps.FusionTablesLayer({
			query: {
				select: 'name',
				from: '1Tb6rqCR-YqIrvfJ07wIkH0-QFnE26b3U3hriuYkq'
			}
		});
		
		var map = new google.maps.Map(document.getElementById("map-canvas"),
			mapOptions);
		layer2.setMap(map);
	}
	initialize();
}




$(function() {
	getCoords();
	
});