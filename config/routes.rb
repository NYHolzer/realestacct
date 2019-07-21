Rails.application.routes.draw do
  root 'sessions#home'
  get '/signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :units
  resources :buildings
  resources :users

  resources :buildings, only: [:show, :index]
    resources :units, only: [:show, :index, :new, :edit]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
