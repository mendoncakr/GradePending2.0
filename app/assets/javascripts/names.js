var namesAjax = function() {
	return $.ajax({
		url : 'restaurants/index.json',
		method : 'get',
		success : function(response) {
			$('#search').autocomplete({source: response})
		}
	});
}

$(function() {
	namesAjax();
})