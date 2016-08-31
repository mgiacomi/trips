Rails.application.routes.draw do

  match '/todo'  => 'todos#status',  :as => :todos_home, :via => :get
  match '/denied' => 'todos#denied',  :as => :denied,     :via => :get
  match '/receipt' => 'payments#receipt',   :as => :payments_receipt,  :via => :post
  match '/payments' => 'payments#overview', :as => :payments_overview, :via => :get

  match '/registration'           => 'registrations#edit',        :as => :registrations_edit,         :via => :get
  match '/registration'           => 'registrations#update',      :as => :registrations,              :via => [:post,:put,:patch]
  match '/registration/chaperone' => 'registrations#chaperone',   :as => :registrations_chaperone,    :via => [:post]
  match '/registration/loi'       => 'registrations#upload_loi',  :as => :registrations_upload_loi,   :via => :post
  match '/registration/loi/:file_name' => 'registrations#download_loi', :as => :registrations_download_loi, :via => :get

  devise_for :users

  match '/tmgr' => 'tmgr/overviews#index', :as => :tmgr_overview, :via => :get
  match '/tmgr/overview/loi/:grade/:outstanding' => 'tmgr/overviews#loi', :as => :tmgr_overview_loi, :via => :get
  match '/tmgr/overview/registered/:grade/:type' => 'tmgr/overviews#registered', :as => :tmgr_overview_registered, :via => :get
  match '/tmgr/overview/past_due/:grade/:type' => 'tmgr/overviews#past_due', :as => :tmgr_overview_past_due, :via => :get

  match '/tmgr/forms/view/:id' => 'tmgr/overviews#view', :as => :tmgr_form_view, :via => :get
  match '/tmgr/forms/loi/:id' => 'tmgr/overviews#download_loi', :as => :tmgr_form_loi, :via => :get

  match '/tmgr/search' => 'tmgr/overviews#search', :as => :tmgr_search, :via => [:post,:put]

  match '/tmgr/payment/:id' => 'tmgr/overviews#payment', :as => :tmgr_payment, :via => [:post,:put]
  match '/tmgr/delete/payment' => 'tmgr/overviews#payment_delete', :as => :tmgr_payment_delete, :via => [:post]

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
