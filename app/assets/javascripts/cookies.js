var MapView = {
	showMap : function () {
		return $('.map_and_search').fadeIn('slow');
	}, 
	hideElement : function (element) {
		return element.hide()
	}
}

var sessionChecker = function () {
	//TODO FIX ME
	var explore = document.cookie.split(';').pop()
	var bool = explore.split('=').pop()

	if (bool === "false") {
		MapView.showMap();

		if (document.getElementById('map-canvas') !== null) {
			GoogleMaps.initializeLargeMap();
		}
		// $('#explore').hide();
		MapView.hideElement($('#explore'))
	} else {
		MapView.hideElement($('.map_and_search'))

		$("#explore").on("click", function(){
			MapView.showMap();
			// $('.map_and_search').fadeIn('slow');
			GoogleMaps.initializeLargeMap()
			$(this).hide();
		})
	}
}

$(function () {
	sessionChecker();
	$('#explore').click(function () {
		document.cookie = "explore=false"
	})
});
