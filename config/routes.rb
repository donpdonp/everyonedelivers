ActionController::Routing::Routes.draw do |map|
  map.resources :deliveries, :member => {:accept => :put, :confirm => :put}
  map.resources :users, :member => {:update_location => :put}
  map.resources :locations
  map.resources :packages
  map.resources :journal, :collection => {:count => :get}
  map.root :controller => "dashboard"

  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
