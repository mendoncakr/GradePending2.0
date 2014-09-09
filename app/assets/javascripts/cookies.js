sessionChecker = function () {
	var explore = document.cookie.split(';').pop()
	var bool = explore.split('=').pop()

	if (bool === "false") {
		$('.map_and_search').fadeIn('slow');
		initializeLargeMap();
		$('#explore').hide();
	} else {
		$('.map_and_search').hide();
	}


}

$(function () {
	sessionChecker();
	$('#explore').click(function () {
		document.cookie = "explore=false"
	})
});
