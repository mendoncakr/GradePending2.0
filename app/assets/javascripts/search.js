function namesforSearchAjax (callback) {
	$.get('restaurants/index.json')
	.done(function (data) {
		callback (data)
	});
}		

$(function() {
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
});	



