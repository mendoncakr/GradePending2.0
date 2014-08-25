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

	$(document).one("load", function(){ namesAjax(); })
	// getCoords();
	initialize();
  // $(".homepage").load( function(){ initialize(); });

  namesAjax(function (response) {
    namesAndIds = response
    var sr =  $.map(namesAndIds, function (key, value) {
    	return {
        label : value,
        value : value,
        id: key
      };
    });
    $('#search').autocomplete({source: sr, change: function (event, ui) {
      id = ui.item.id;   
    }})

  });

  $('form').on('submit', function (e) {
  	e.preventDefault()
  	// var id = document.getElementById('search').value;
  	window.location = "/restaurants/"+ id
    

  })
});