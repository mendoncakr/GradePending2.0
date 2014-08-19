function initialize() {
    var mapOptions = {
        center: new google.maps.LatLng(40.766579, -73.9783445),
        zoom: 8
    };
    var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
    var layer2 = new google.maps.FusionTablesLayer({
        query: {
            select: 'name',
            from: '1Tb6rqCR-YqIrvfJ07wIkH0-QFnE26b3U3hriuYkq'
        }
    });
    layer2.setMap(map);

    layer2.enableMapTips({
        select: "'name'", // list of columns to query, typially need only one column.
        from: '1Tb6rqCR-YqIrvfJ07wIkH0-QFnE26b3U3hriuYkq', // fusion table name
        geometryColumn: "latitude", // geometry column name
        suppressMapTips: false, // optional, whether to show map tips. default false
        delay: 200, // milliseconds mouse pause before send a server query. default 300.
        tolerance: 8,
        key: 'AIzaSyBhUWJ1yNQ8jFdmSGBUjvn7ol2zB_nkdtI'
    });

}

$(function() {
  initialize();
  namesAjax(function (response) {
    namesAndIds = response
    names  = response.map( function (resp){return resp[1]})
    console.log(names)
    $('#search').autocomplete({source: names})

  });

  $('form').on('submit', function (e) {
  	e.preventDefault()
  	var restaurantName = document.getElementById('search').value.toUpperCase();
  	console.log(restaurantName);
  	for (var i = 0; i < namesAndIds.length; i++) { 
  		for (var j = 0; j < namesAndIds[i].length; j++) {
  			console.log( namesAndIds[i][j]);
  		}
  	}



  })
});