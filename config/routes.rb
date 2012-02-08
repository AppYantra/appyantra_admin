Rails.application.routes.draw do
  # To use this engine in your app use the following
  # mount AppyantraAdmin::Engine => "/appyantra_admin"
  match '/appyantra_admin' => 'appyantra_admin/home#index', :as => :appyantra_admin_home, :via => :get
  
  devise_for :admin, :path => 'appyantra_admin', :controllers => { :sessions => 'appyantra_admin/sessions', :passwords => 'appyantra_admin/passwords' }
    # match '/appyantra_admin/sign_in' => 'appyantra_admin/sessions#new', :as => :new_admin_session, :via => :get
    #     match '/appyantra_admin/sign_in' => 'appyantra_admin/sessions#create', :as => :admin_session, :via => :post
    #     match '/appyantra_admin/sign_out' => 'appyantra_admin/sessions#destroy', :as => :destroy_admin_session, :via => :delete
    #     match '/appyantra_admin/password' => 'appyantra_admin/passwords#create', :as => :admin_password, :via => :post
    #     match '/appyantra_admin/password/new' => 'appyantra_admin/passwords#new', :as => :new_admin_password, :via => :get
    #     match '/appyantra_admin/password/edit' => 'appyantra_admin/passwords#edit', :as => :edit_admin_password, :via => :get
    #     match '/appyantra_admin/password' => 'appyantra_admin/passwords#edit', :as => :update_admin_password, :via => :put
                           
  # Admin profiles
  match '/appyantra_admin/profiles/new' => 'appyantra_admin/profiles#new', :as => :new_admin, :via => :get
  match '/appyantra_admin/profiles/:id' => 'appyantra_admin/profiles#show', :as => :admin_profile, :via => :get
  match '/appyantra_admin/profiles/:id/edit' => 'appyantra_admin/profiles#edit', :as => :edit_admin_profile, :via => :get
  match '/appyantra_admin/profiles/:id' => 'appyantra_admin/profiles#destroy', :as => :delete_admin_profile, :via => :delete
  match '/appyantra_admin/profiles/:id' => 'appyantra_admin/profiles#update', :as => :update_admin_profile, :via => :put
  match '/appyantra_admin/profiles/:id/password' => 'appyantra_admin/profiles#update_password', :as => :update_admin_password, :via => :put
  match '/appyantra_admin/profiles' => 'appyantra_admin/profiles#index', :as => :admin_profiles, :via => :get  
  match '/appyantra_admin/profiles' => 'appyantra_admin/profiles#create', :as => :create_admin, :via => :post
  
  # assets
  match '/appyantra_admin/assets/:asset_name' => 'appyantra_admin/assets#show', :as => :assets, :via => :get
  match '/appyantra_admin/assets/:asset_name/:id/show' => 'appyantra_admin/assets#show', :as => :show_asset, :via => :get
  match '/appyantra_admin/assets/:asset_name/new' => 'appyantra_admin/assets#new', :as => :new_asset, :via => :get
  match '/appyantra_admin/assets/:asset_name' => 'appyantra_admin/assets#create', :as => :create_asset, :via => :post
  match '/appyantra_admin/assets/:asset_name/:id' => 'appyantra_admin/assets#destroy', :as => :delete_asset, :via => :delete
  match '/appyantra_admin/assets/:asset_name/:id/display' => 'appyantra_admin/assets#display', :as => :display_asset, :via => :get
  match '/appyantra_admin/assets/:asset_name/:id/edit' => 'appyantra_admin/assets#edit', :as => :edit_asset, :via => :get
  match '/appyantra_admin/assets/:asset_name/:id' => 'appyantra_admin/assets#update', :as => :update_asset, :via => :put
  
  # admin settings
  match '/appyantra_admin/settings' => 'appyantra_admin/admin_settings#index', :as => :settings
  match '/appyantra_admin/settings/new' => 'appyantra_admin/admin_settings#new', :as => :new_setting, :via => :post
  match '/appyantra_admin/settings/:entity_type/:setting_name' => 'appyantra_admin/admin_settings#create', :as => :create_setting, :via => :post
  match '/appyantra_admin/settings/:id/edit' => 'appyantra_admin/admin_settings#edit', :as => :edit_setting, :via => :get
  match '/appyantra_admin/settings/:id' => 'appyantra_admin/admin_settings#update', :as => :update_setting, :via => :put
  match '/appyantra_admin/settings/:id' => 'appyantra_admin/admin_settings#destroy', :as => :delete_setting, :via => :delete
end
