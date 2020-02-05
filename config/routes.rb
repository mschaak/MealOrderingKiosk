Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'navigations#home' #:to => redirect('/admins/home')
  devise_for :students, controllers: {
    sessions: 'students/sessions',
    registrations: 'students/registrations'
  }
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  resources :orders
  resources :meals

  # match '/admin_login', to: 'sessions#admin_login', via: :get
  # match '/admin_login_create', to: 'sessions#admin_login_create', via: :post
  # match '/logout', to: 'sessions#destroy', via: :delete
  match '/navigation_adminnavigation', to: 'navigations#adminnavigation', via: :get
  #
  # match '/student_login', to: 'sessions#student_login', via: :get
  # match '/student_login_create', to: 'sessions#student_login_create', via: :post
  match '/current_menu', to: 'meals#current_menu', via: :get
  match '/order_history', to: 'orders#order_history', via: :get
  match '/navigation_studentnavigation', to: 'navigations#studentnavigation', via: :get
  match '/order_show', to: 'orders#show', via: :get
  match '/navigation_show_admin', to: "navigations#admin_show", via: :get
  match '/navigation_show_student', to: "navigations#student_show", via: :get
  match '/schedule', to: "meals#schedule", via: :post
  match '/tomorrows_menu', to: "meals#tomorrows_menu", via: :get

  match '/meal_show', to: 'meals#show', via: :get

  match "*path", to: "navigations#home", via: :all
  #post 'meals/schedule'
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
  #   namespace :admins do
  #     # Directs /admins/products/* to Admin::ProductsController
  #     # (app/controllers/admins/products_controller.rb)
  #     resources :products
  #   end
end
