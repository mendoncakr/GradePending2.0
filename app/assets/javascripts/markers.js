var getCoords = function() {
	console.log('yolo')
	return $.ajax({
		url: '/markers.json',
		method: 'get',
		success: function(resp) {

			console.log(resp.restaurants)
			
			function initialize() {
				var mapOptions = {
					center: new google.maps.LatLng(40.766579, -73.9783445),
					zoom: 14
				};
				var map = new google.maps.Map(document.getElementById("map-canvas"),
					mapOptions);
				var infowindow = new google.maps.InfoWindow({});
				for ( var i =0; i < resp.restaurants.length; i++) {
					var marker = new google.maps.Marker({
						position: new google.maps.LatLng(resp.restaurants[i][1], resp.restaurants[i][2]),
						map : map
					});
					marker.info = { name : resp.restaurants[i][0], id: resp.restaurants[i][3]}

				google.maps.event.addListener(marker, 'click', (function(marker, i) {
						return function() {
							infowindow.setContent('<bold>Name: '+'<a href="/restaurants/'+marker.info.id+'">'+marker.info.name +'</a></bold>')
							infowindow.open(map, marker);
						}
					})(marker, i));
				}
					
			}
			initialize();
		}
	});
}




$(function() {
	getCoords();
	
});