Cove::Application.routes.draw do

  resources :intervals

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
  
  root  :to => "welcome#index"
end
