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

	function restaurantAjax (callback){
		var id = document.URL.split('/').pop();
		$.get ('/restaurants/' +id+ '.json').success(function (data) {
			callback (data)
		});
	}

			
function initialize2(data) {
	var restaurant = data.name;
	var latitude = data.latitude;
	var longitude = data.longitude;
	var myLatlng = new google.maps.LatLng(latitude,longitude);
		var mapOptions = {
			center: new google.maps.LatLng(latitude, longitude),
			zoom: 15,
			disableDefaultUI: true
		};

		var map = new google.maps.Map(document.getElementById("map-canvas2"), mapOptions);
		var marker = new google.maps.Marker({
			position: myLatlng,
			map: map,
			title: restaurant.str
		});
}
	




	$(function(){
		$('.restaurant').addClass('animated fadeInLeft');

		if (document.getElementById('map-canvas2') !== null) {
			restaurantAjax(function(response) {
				initialize2(response);
			});

		}

	})