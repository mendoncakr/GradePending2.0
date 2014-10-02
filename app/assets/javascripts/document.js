$(function(){
  if (document.getElementById('container') !== null) {
    getAjax('/stats', function(response) {
      var gradePending = response.grades['N'] + response.grades[""]
      highCharts.totalGrades(response, gradePending)
      highCharts.commonViolations(response)
    });
  }

  if (document.getElementById('similar') !== null) {
    var id = document.URL.split('/').pop()
    var re = /[.]/
    if (re.test(id) === true) {
      id = id.split('.')[0]
    }

    getAjax('/restaurants/'+id+'.json', function (response) {
      highCharts.similarlyGraded(response)
      GoogleMaps.initializeSmallMap(response)
    })
    
  }
  // Responsive Nav Links 
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

  // Search Bar Autcomplete 
  var searchWrapper = (function () {
    var that = this;

    getAjax('/restaurants/index.json', function (response) {
      var namesAndIds = response;
      var sr =  $.map(namesAndIds, function (key, value) {
       return {
        label : value,
        value : value,
        id: key
        };
      });
      $('#search').autocomplete({source: sr, minLength: 3, change: function (event, ui) {
        that.id = ui.item.id;
      }})

    });
  })();

  //Assign Cookie after clicking explore. 

  sessionChecker();
    $('#explore').click(function () {
      document.cookie = "explore=false"
    })
})
