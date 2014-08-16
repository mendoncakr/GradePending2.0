Rails.application.routes.draw do
 devise_for :users  
	root to: "restaurants#index"

	get '/restaurants/:id', to: 'restaurants#search'
	get '/restaurants/search', to: 'restaurants#show', as: :restaurants_search

	# get 'markers.:format', to: "markers#index", as: :markers, constraints: {:format => /json/ } 
	get '/markers', to: "markers#markers"
end

