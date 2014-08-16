Rails.application.routes.draw do
 devise_for :users  
	root to: "restaurants#index"

	get '/restaurants/:id', to: 'restaurants#show'
	get '/restaurants/search', to: 'restaurants#search', as: :restaurants_search

	# get 'markers.:format', to: "markers#index", as: :markers, constraints: {:format => /json/ } 
	get '/markers', to: "markers#markers"
end

