Rails.application.routes.draw do
<<<<<<< HEAD

  devise_for :users
  root to: "restaurants#index"
=======
 devise_for :users  
	root to: "restaurants#index"
	get 'restaurants/index.:format', to: "restaurants#index", as: :restaurant_names, constraints: {:format => /json/}
	get '/restaurants/:id', to: 'restaurants#show'
	get '/restaurants/search', to: 'restaurants#search', as: :restaurants_search

	# get 'markers.:format', to: "markers#index", as: :markers, constraints: {:format => /json/ } 
	get '/markers', to: "markers#markers"
>>>>>>> bb2719b00ce33d6ef4e67a6e0cf15dd9a2c86a9b
end

