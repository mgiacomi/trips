Rails.application.routes.draw do

  match '/payments/overview' => 'payments#overview',          :as => :payments_overview,          :via => :get

  match '/registration'      => 'registrations#edit',         :as => :registrations_edit,         :via => :get
  match '/registration'      => 'registrations#update',       :as => :registrations,              :via => [:post,:put,:patch]
  match '/registration/loi'  => 'registrations#upload_loi',   :as => :registrations_upload_loi,   :via => :post
  match '/registration/loi/:file_name' => 'registrations#download_loi', :as => :registrations_download_loi, :via => :get

  match '/todo'  => 'todos#status',  :as => :todos_home, :via => :get
  match '/denied' => 'todos#denied',  :as => :denied,     :via => :get

  devise_for :users

  match '/tmgr/overview'               => 'tmgr/overviews#index',      :as => :tmgr_overview,            :via => :get

  root 'todos#status'

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
