Rails.application.routes.draw do
  root 'sessions#home'
  get '/signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  #omniauth callback
  get '/auth/facebook/callback' => 'sessions#fbcreate'

  get '/tenants' => 'units#index'

  resources :units, :except => [:index]
  resources :buildings
  resources :users
  resources :expenses
  resources :revenues

  resources :buildings, only: [:show, :index] do
    resources :units, only: [:show, :index, :new, :edit]
  end

  resources :units, only: [:show, :index] do 
    resources :expenses, only: [:show, :index, :new, :edit]
  end
  
  resources :units, only: [:show, :index] do 
    resources :revenues, only: [:show, :index, :new, :edit]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
