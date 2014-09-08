function initialize() {
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

}

var restaurantView = function () {};

restaurantView.prototype.searchBar = function () {
  return $('.search');
}



$(function() {
  var RestaurantView = new restaurantView();
  var search = RestaurantView.searchBar();

	$(document).one("load", function(){ namesAjax(); })


	if (document.getElementById('map-canvas') !== null) {
    // initialize();
  }
   
  var searchWrapper = (function () {
    var that = this;

    namesAjax(function (response) {
      var namesAndIds = response;
      var sr =  $.map(namesAndIds, function (key, value) {
       return {
        label : value,
        value : value,
        id: key
      };
    });
      $('#search').autocomplete({source: sr, change: function (event, ui) {
        that.id = ui.item.id;   
      }})

    });

    $('.search').on('submit', function (e) {
     e.preventDefault()
     window.location = "/restaurants/"+ that.id
   })
  })();
});