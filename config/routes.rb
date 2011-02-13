Cove::Application.routes.draw do

  resources :intervals

  resources :projects
  
  resources :collections
  match 'collections/:id/add/:interval' => 'collections#add', :as => :add_to_collection
  match 'collections/:id/remove/:interval' => 'collections#remove', :as => :remove_from_collection

  devise_for :users, :path => "/", :path_names => {:sign_in => "login", 
    :sign_out => "logout"}
  
  controller :nda do
    get "/nda" => "nda#index"
    post "/nda" => "nda#create"
  end
  
  resources :invitations, :only => [:edit, :update]
  match 'invitations/' => 'invitations#new'
  
  namespace :admin do
    resources :users, :only => [:index, :new, :create]
  end
  
  root  :to => "intervals#index"
end
