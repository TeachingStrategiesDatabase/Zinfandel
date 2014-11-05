Rails.application.routes.draw do

  get 'new' => 'strategies#new'
  get 'home' => 'example#home'
  post 'create' => 'strategies#create'

  # default_url_options :host => "localhost:3000"

	post 'users/create' => 'users#create'
get 'users/new' => 'users#new'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
	#resources :users
  #resources :strategies
  # You can have the root of your site routed with "root"

  root 'static#homepage'

  # Login mapping
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  match 'logout' => 'sessions#destroy', :via => [:get, :post]

  match 'homepage' => 'static#homepage', :via => [:get, :post]

	post 'strategies/:id/delete' => 'strategies#destroy', :as => 'strategy_delete'
  get "strategies/new" => "strategies#new"
  get "strategies/search" => "strategies#search"
  get "strategies/show" => "strategies#show"
  get "strategies/update" => "strategies#update"
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
