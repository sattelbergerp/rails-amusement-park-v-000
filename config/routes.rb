Rails.application.routes.draw do
    root 'application#index'

    resources :users
    resources :attractions
    post '/attractions/:id/ride' => 'attractions#ride', as: :ride_attraction
    get '/signin' => 'sessions#new', as: :new_session
    post '/signin' => 'sessions#create', as: :create_session
    get '/signout' => 'sessions#destroy', as: :destroy_session

end
