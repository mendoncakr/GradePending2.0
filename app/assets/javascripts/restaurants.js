var authenticityToken =  function(xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')) };

var favoritedSuccessfully = '<li> Added to your favorites! </li>';
var favoriteAlreadyThere = '<li> Looks like in your favorites already! </li>';

var addFavorite = function(id) {
	$.ajax({
		url: '/restaurants/'+ id +'/favorite',
		beforeSend: authenticityToken,
		method: "POST"
	}).success(function(response){
		$('.messages').append(favoritedSuccessfully).fadeIn("slow", function(){ 
			$(this).fadeOut(3000);
			$('#add_favorite').hide()
	  })
	}).fail(function(response){
		$('.messages').append(favoriteAlreadyThere).fadeIn("slow", function(){ 
			$(this).fadeOut(3000);  })
	})};

	$(function(){
		$("#add_favorite").on("click", function(e){
			e.preventDefault();	
			var restaurantID = $('#add_favorite').data("restaurant");  // Setting restaurant ID here for now, need to set up even delegation as we are currently binding to element before it is created in the DOM
			addFavorite(restaurantID);
		});
	});


