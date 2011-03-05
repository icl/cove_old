Cove::Application.routes.draw do

  resources :intervals do
    resources :snippets
    resources :annotations
    resources :taggings, :only => [:show, :create]
    resources :codings, :only => [:show, :create]
  end

  resources :definitions

  resources :projects do
    resources :notes
  end
  
  resources :collections
  # Collections General Routes
  match 'collections/:id/add/:interval' => 'collections#add', :as => :add_to_collection
  match 'collections/:id/remove/:interval' => 'collections#remove', :as => :remove_from_collection
  match 'collections/:id/prioritize/:interval/:direction' => 'collections#prioritize_interval', :as => :prioritize_interval
  match 'collections/:id/prioritize' => 'collections#prioritize_intervals', :as => :prioritize_intervals
  # Project specific Collection Routes
  match 'projects/:id/add/:collection' => 'projects#add_collection', :as => :add_collection
  match 'projects/:id/remove/:collection' => 'projects#remove_collection', :as => :remove_collection
  match 'projects/:id/favorites' => 'collections#show', :as => :favorite_intervals
  match 'projects/:id/favorites/add/:interval' => 'collections#add', :as => :add_to_project_favorites
  match 'projects/:id/favorites/remove/:interval' => 'collections#remove', :as => :remove_from_project_favorites
  match 'projects/:id/queue' => 'collections#show', :as => :interval_queue
  match 'projects/:id/queue/add/:interval' => 'collections#add', :as => :add_to_project_queue
  match 'projects/:id/queue/remove/:interval' => 'collections#remove', :as => :remove_from_project_queue
  # User specific Collection Routes
  match 'users/:id/favorites' => 'collections#show', :as => :user_favorites
  match 'users/:id/favorites/add/:interval' => 'collections#add', :as => :add_to_user_favorites
  match 'users/:id/favorites/remove/:interval' => 'collections#remove', :as => :remove_from_user_favorites
  match 'users/:id/queue' => 'collections#show', :as => :user_queue
  match 'users/:id/queue/add/:interval' => 'collections#add', :as => :add_to_user_queue
  match 'users/:id/queue/remove/:interval' => 'collections#remove', :as => :remove_from_user_queue

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

