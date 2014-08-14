var getCoords = function() {
	console.log('yolo')
		$.ajax({
		url: '/markers.json',
		method: 'get',
		success: function(resp) {
			console.log(resp.restaurants)
			for ( var i =0; i < resp.restaurants.length; i++){
				var marker_i = new google.maps.Marker({
					position: new google.maps.LatLng(resp.restaurants[i][0], resp.restaurants[i][1])
				})
				console.log(marker_i)
			}
		console.log('hey');
		},
		fail: function(resp) {
			console.log(resp)
		}
	});
}

$(function() {
	getCoords();
	
});