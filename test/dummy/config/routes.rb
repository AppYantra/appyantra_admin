Dummy::Application.routes.draw do
  mount AppyantraAdmin::Engine => "/appyantra_admin"
  root :to => 'appyantra_admin/home#index'
end
