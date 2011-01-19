Cove::Application.routes.draw do
  get "welcome/index"

  devise_for :users, :path => "/", :path_names => {:sign_in => "login", 
    :sign_out => "logout"}
  
  controller :nda do
    get "/nda" => "nda#index"
    post "/nda" => "nda#create"
  end
  
  resources :invitations, :only => [:new, :create, :edit, :update]
  
  root  :to => "welcome#index"
end
