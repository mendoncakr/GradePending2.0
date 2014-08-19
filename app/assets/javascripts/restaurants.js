var authenticityToken =  function(xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')) }

var addFavorite = function(id) {
	$.ajax({
		url: '/restaurants/'+ id +'/favorite',
		beforeSend: authenticityToken,
		method: "POST",
	}).success(function(response){
		console.log("SUCCESSFULLY added restaurant as a favorite! :) ");
		console.log(response);
	}).fail(function(response){
		console.log("FAILED to add restaurant as favorite :( ");
			console.log(response);
		});
}

$(function(){
	console.log("Working!");

	$("#add_favorite").on("click", function(e){
		var restaurantID = $('#add_favorite').data("restaurant")  // Setting restaurant ID here for now, need to set up even delegation as we are currently binding to element before it is created in the DOM
		e.preventDefault();	
		addFavorite(restaurantID);
	})

});


