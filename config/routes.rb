Cove::Application.routes.draw do
  devise_for :users, :path => "/", :path_names => {:sign_in => "login", 
    :sign_out => "logout"}
  
  resources :nda, :only => [:index, :create]
  
  root  :to => "place_holder#index"
end
