GoogleMaps = {
  initializeLargeMap : function () {
    var mapOptions = {
      center: new google.maps.LatLng(40.766579, -73.9783445),
      zoom: 15
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

  },

  initializeSmallMap: function (data) {
	  var restaurant = data.name;
	  var latitude = data.latitude;
	  var longitude = data.longitude;
	  var myLatlng = new google.maps.LatLng(latitude,longitude);
    var mapOptions = {
      center: new google.maps.LatLng(latitude, longitude),
      zoom: 15,
      disableDefaultUI: true
    };

    var map = new google.maps.Map(document.getElementById("map-canvas2"), mapOptions);
    var marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      title: restaurant
    });
  }
}