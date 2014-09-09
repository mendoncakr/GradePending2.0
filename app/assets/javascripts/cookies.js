var sessionChecker = function () {
	//TODO FIX ME
	var explore = document.cookie.split(';').pop()
	var bool = explore.split('=').pop()

	if (bool === "false") {
		$('.map_and_search').fadeIn('slow');
		if (document.getElementById('map-canvas') !== null) {
			GoogleMaps.initializeLargeMap();
		}
		$('#explore').hide();
	} else {
		$('.map_and_search').hide();

		$("#explore").on("click", function(){
			$('.map_and_search').fadeIn('slow');
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
