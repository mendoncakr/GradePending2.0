var namesAjax = function() {
	return $.get('restaurants/index.json', function(response) {
			$('#search').autocomplete({source: response})
		});
}

$(function() {
	namesAjax();
})