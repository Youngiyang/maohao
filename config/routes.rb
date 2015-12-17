Rails.application.routes.draw do
  namespace :seller do
    get 'sessions/new'
    get "login" => 'sessions#new'
    post "login" => 'sessions#create'
    delete "logout" => 'sessions#destroy'
    resources :users, only: [:show]
    get "reset_password" => 'password#new'
    post "reset_password" => 'password#reset_from_web'
    get "forget_password" => 'password#forget'
    post "forget_password" => 'password#reset_from_mobile'
    post "send_code" => 'auth_code#send_code'
  end

  namespace :admin do
    get 'sessions/new'
    get "login" => 'sessions#new'
    post "login" => 'sessions#create'
    delete "logout" => 'sessions#destroy'
    get "reset_password" => 'password#new'
    post "reset_password" => 'password#reset_from_web'
    resources :admins, only: [:show]



  end


  resources :templates
  get 'temp_index' => 'templates#index'
  get 'temp_manageuser' => 'templates#manageuser'
  get 'temp_manageshop' => 'templates#manageshop'
  get 'temp_login' => 'templates#login'
  get 'temp_forgetpasswd' => 'templates#forgetpasswd'
  get 'temp_admin_login' => 'templates#admin_login'
  root 'officialsite/website#index'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
