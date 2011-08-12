Webphusion::Application.routes.draw do
	# user routings
	resources :users
	match '/register' => 'users#new'
	match 'connect_account' => 'users#connect_account'
	# session routings
	resources :sessions
	match '/login' => 'sessions#new'
	match '/logout' => 'sessions#destroy'
	# rest
	resources :dashboards
	resources :invitations
	resources :themes
	resources :websites
	root :to => 'dashboards#index'
end
