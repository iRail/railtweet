Railtweet::Application.routes.draw do
  resources :trackings

  resources :vehicles

  resources :vehicle_stop_delays

  resources :vehicle_stops

  resources :connection_stops

  resources :connections

  resources :one_way_trips

  resources :stations

  resources :users

  get "public/index"
  root :to => "public#index"
  
  match "/trip_info" => "public#trip_info"
  
  match "/update" => "public#update", :as => :update_twitter
  match "/auth/twitter/callback" => "session#create"
  match "/signout" => "session#destroy", :as => :signout
  
end
