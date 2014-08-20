function namesAjax (callback) {
	$.get('restaurants/index.json')
	.done(function (data) {
		callback (data)
	});
}			

	

