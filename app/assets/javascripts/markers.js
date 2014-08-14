var getCoords = function() {
	console.log('yolo')
	return $.ajax({
		url: '/markers.json',
		method: 'get',
		success: function(resp) {

			console.log(resp.restaurants)
			
			function initialize() {
				var mapOptions = {
					center: new google.maps.LatLng(40.7731024, -73.872255),
					zoom: 12
				};
				var map = new google.maps.Map(document.getElementById("map-canvas"),
					mapOptions);

				var infowindow = new google.maps.InfoWindow({
					content: 'YOLOYLOYLYOYLYOLYOYLYOYLYOYLYO'
				});
				var that = map;
				for ( var i =0; i < resp.restaurants.length; i++) {
					var marker = new google.maps.Marker({
						position: new google.maps.LatLng(resp.restaurants[i][0], resp.restaurants[i][1]),
						map : map
					});
				}	
			}
			initialize();
		}
	});
}




$(function() {
	getCoords();
	getCoords().done(function() {
	});	
	
});