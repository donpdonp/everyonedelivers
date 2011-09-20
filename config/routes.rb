EveryoneDelivers::Application.routes.draw do
  resources :deliveries do
    member do
      put :accept
      put :confirm
    end  
  end

  resources :users do
    member do
      put :update_location
      post :clock_in
      post :clock_out
    end
  end

  resources :locations
  resources :packages
  resources :journal do
    collection do
      get :count
      end
  end

  match '/' => 'dashboard#index'
  match '/:controller(/:action(/:id))'

end
