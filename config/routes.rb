Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  get 'pages/home', :as => 'home'
  get 'pages/about', :as => 'about'
  get 'pages/portafolio', :as => 'portafolio'
  get 'pages/contacto', :as => 'contacto'
  get 'pages/blog', :as => 'blog'
  match "checkout", to: "orders#checkout", as: "checkout", via: [:get, :patch]

  mount Shoppe::Engine => "/shoppe"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get "product/:permalink", to: "products#show", as: "product"
  post "product/:permalink", to: "products#buy", as: "buy"
  get 'products/:category_id' => 'products#index', :as => 'products'  
  get 'products/:category_id/:subcategory_id' => 'products#index', :as => 'products_sub' 
  root to: "pages#home"
  get "basket", to: "orders#show"
  
  
  post 'products/:category_id/:product_id/buy' => 'products#add_to_basket', :as => 'buy_product'
  delete 'basket/delete/:order_item_id' => 'orders#remove_item', :as => 'remove_basket_item'
  
  
  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
