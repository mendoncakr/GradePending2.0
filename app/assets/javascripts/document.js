$(function(){
  if (document.getElementById('map-canvas2') !== null) {
    restaurantAjax(function(response) {
      var data = response;
      GoogleMaps.initializeSmallMap(data);
      highCharts.similarlyGraded(data);
    });
  }

  if (document.getElementById('container') !== null) {
    gradesAjax(function(response) {
      var gradePending = response.grades['N'] + response.grades[""]
      highCharts.totalGrades(response, gradePending)
      highCharts.commonViolations(response)
    });
  }
  (function () {
    var navBar = new NavBar($("#nav_links"), $(window), $('#menu'))
    navBar.addClass()
    navBar.tog()
    navBar.removeA()
  })()



  $("#add_favorite").on("click", function(e){
    e.preventDefault();
    var restaurantID = $('#add_favorite').data("restaurant");  // Setting restaurant ID here for now, need to set up even delegation as we are currently binding to element before it is created in the DOM
    addFavorite(restaurantID);
  });

  $(document).one("load", function(){ namesAjax(); })

  var searchWrapper = (function () {
    var that = this;

    namesforSearchAjax(function (response) {
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
        console.log(that.id)
      }})

    });

    $('.search').on('submit', function (e) {
     e.preventDefault()
     window.location = "/restaurants/"+ that.id
   })
  })();

})
