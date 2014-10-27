function getAjax (route, callback) {
  $.get(route)
  .done(function (data) {
    callback (data);
  });
}
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

function restaurantAjax (callback){
  var id = document.URL.split('/').pop();
  $.get ('/restaurants/' +id+ '.json').success(function (data) {
    callback (data)
  });
}


