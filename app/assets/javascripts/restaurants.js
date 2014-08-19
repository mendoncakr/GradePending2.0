// var restaurant = function(){ 
// 	return $.get('/restaurants/:id.json', function(response){
// 		console.log(response);
// 	}); 
// }

var addFavorite = function() {
	$.ajax({
		url: '/restaurants/:id/favorite',
		method: "POST"
	}).success(function(response){
		console.log("SUCCESSFULLY added restaurant as a favoite! :) ");
		console.log(response);
	}).fail(function(response){
		console.log("FAILED to add restaurant as favorite :( ");
		console.log(response);
	});
}

$(document).ready(function(){
	console.log("Working!");

	$("#add_favorite").on("click", function(e){
		e.preventDefault();
		console.log("CLICK!")
		addFavorite();
	})

});
