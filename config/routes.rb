Rails.application.routes.draw do

 devise_for :users

	root to: "restaurants#index"

	get '/restaurants/index.:format', to: "restaurants#index", as: :restaurant_names, constraints: {:format => /json/}
	
	get '/restaurants/:id', to: 'restaurants#show'
	get '/restaurants/:id.:format', to: 'restaurants#show', as: :restaurants_show, constraints: {:format => /json/}

	get '/restaurants/search', to: 'restaurants#search', as: :restaurants_search

	post '/restaurants/:id/favorite', to: 'restaurants#favorite', as: :add_favorite_restaurant

	get '/markers', to: "markers#markers"

	get '/stats', to: 'restaurants#statistics', as: :restaurant_stats, constraints: {:format => /json/}

	


	#User Routes
	get '/users/home', to: "users#index", as: :my_account

end

