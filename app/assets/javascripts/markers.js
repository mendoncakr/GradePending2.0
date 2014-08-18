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

		layer2.enableMapTips({
      		select: "'name'", // list of columns to query, typially need only one column.
      		from: '1Tb6rqCR-YqIrvfJ07wIkH0-QFnE26b3U3hriuYkq', // fusion table name
          geometryColumn: 'latitude', // geometry column name
      		suppressMapTips: false, // optional, whether to show map tips. default false
          delay: 200, // milliseconds mouse pause before send a server query. default 300.
          tolerance: 8,
          key: 'AIzaSyBhUWJ1yNQ8jFdmSGBUjvn7ol2zB_nkdtI'
      	});
              //listen to events if desired.
              google.maps.event.addListener(layer2, 'mouseover', function(fEvent) {
              	var row = fEvent.row;
              	myHtml = 'mouseover:<br/>';
              	for (var x in row) {
              		if (row.hasOwnProperty(x)) {
              			myHtml += '<b>' + x + "</b>:" + row[x].value + "<br/>";
              		}
              	}
              	document.getElementById('info').innerHTML = myHtml;
              });
              google.maps.event.addListener(layer, 'mouseout', function(fevt) {
              	document.getElementById('info').innerHTML = '';
              });
	}
	initialize();
}




$(function() {
	namesAjax();
	getCoords();
	
});