Rails.application.routes.draw do

  match '/todo'     => 'todos#status',         :as => :todos_home,        :via => :get
  match '/denied'   => 'todos#denied',         :as => :denied,            :via => :get
  match '/support'  => 'todos#support',        :as => :support,           :via => :get
  match '/privacy'  => 'todos#privacy',        :as => :privacy,           :via => :get

  match '/receipt'      => 'payments#receipt',     :as => :payments_receipt,  :via => :post
  match '/onk'          => 'payments#onk_receipt', :as => :onk_receipt,       :via => :post
  match '/payments/:id' => 'payments#overview',    :as => :payments_overview, :via => :get

  match '/parents'  => 'parents#edit',         :as => :parents_edit,      :via => :get
  match '/parents'  => 'parents#update',       :as => :parents_update,    :via => [:post,:put,:patch]

  match '/loi/:id'  => 'forms#loi_new',         :as => :loi_new,      :via => :get
  match '/loi/:id'  => 'forms#loi_create',      :as => :loi_create,   :via => [:post,:put,:patch]

  match '/registration/new'       => 'registrations#new',         :as => :registrations_new,          :via => :get
  match '/registration/new'       => 'registrations#create',      :as => :registrations_create,       :via => :post
  match '/registration/:id'       => 'registrations#edit',        :as => :registrations_edit,         :via => :get
  match '/registration/:id'       => 'registrations#update',      :as => :registrations_update,       :via => [:put,:patch]

  devise_for :users

  match '/tmgr'                                  => 'tmgr/overviews#index',        :as => :tmgr_overview,              :via => :get
  match '/tmgr/overview/loi/:grade/:outstanding' => 'tmgr/overviews#loi',          :as => :tmgr_overview_loi,          :via => :get
  match '/tmgr/overview/onk/:grade/:member'      => 'tmgr/overviews#onk_member',   :as => :tmgr_overview_onk_member,   :via => :get
  match '/tmgr/overview/registered/:grade/:type' => 'tmgr/overviews#registered',   :as => :tmgr_overview_registered,   :via => :get
  match '/tmgr/overview/withdrawn/:grade/:type'  => 'tmgr/overviews#withdrawn',    :as => :tmgr_overview_withdrawn,    :via => :get
  match '/tmgr/overview/scholarships/:grade'     => 'tmgr/overviews#scholarships', :as => :tmgr_overview_scholarships, :via => :get
  match '/tmgr/overview/collected/:grade/:type'  => 'tmgr/overviews#collected',    :as => :tmgr_overview_collected,    :via => :get
  match '/tmgr/overview/past_due/:grade/:type'   => 'tmgr/overviews#past_due',     :as => :tmgr_overview_past_due,     :via => :get

  match '/tmgr/reports/eighthgrade.:format'      => 'tmgr/overviews#eighthgrade',  :as => :tmgr_overview_eighthgrade,  :via => :get
  match '/tmgr/reports/fifthgrade.:format'       => 'tmgr/overviews#fifthgrade',   :as => :tmgr_overview_fifthgrade,   :via => :get
  match '/tmgr/reports/latepayments.:format'     => 'tmgr/overviews#latepayments', :as => :tmgr_overview_latepayments, :via => :get

  match '/tmgr/search'               => 'tmgr/overviews#search',               :as => :tmgr_search,        :via => [:post,:put]
  match '/tmgr/recent/registrations' => 'tmgr/overviews#recent_registrations', :as => :tmgr_registrations, :via => [:post,:put]
  match '/tmgr/recent/payments'      => 'tmgr/overviews#recent_payments',      :as => :tmgr_payments,      :via => [:post,:put]

  match '/tmgr/forms/view/:id'        => 'tmgr/overviews#view',         :as => :tmgr_form_view,        :via => :get
  match '/tmgr/forms/loi/:id'         => 'tmgr/overviews#download_loi', :as => :tmgr_form_loi,         :via => :get
  match '/tmgr/toggle/onk/:id'        => 'tmgr/overviews#toggle_onk',   :as => :tmgr_toggle_onk,       :via => :post
  match '/tmgr/toggle/chaperone/:id'  => 'tmgr/overviews#toggle_chap',  :as => :tmgr_toggle_chaperone, :via => :post
  match '/tmgr/toggle/withdrawn/:id'  => 'tmgr/overviews#toggle_with',  :as => :tmgr_toggle_withdrawn, :via => :post
  match '/tmgr/forms/scholarship/:id' => 'tmgr/overviews#scholarship',  :as => :tmgr_form_scholarship, :via => [:post,:put,:patch]
  match '/tmgr/forms/delete/:id'      => 'tmgr/overviews#delete',       :as => :tmgr_form_delete,      :via => :delete

  match '/tmgr/payment/:id'    => 'tmgr/overviews#payment',        :as => :tmgr_payment,        :via => [:post,:put]
  match '/tmgr/delete/payment' => 'tmgr/overviews#payment_delete', :as => :tmgr_payment_delete, :via => :post

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
