Rails.application.routes.draw do
  resources :expenses
  resources :revenues
  root 'sessions#home'
  get '/signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  #omniauth callback
  get '/auth/facebook/callback' => 'sessions#fbcreate'


  resources :units
  resources :buildings
  resources :users

  resources :buildings, only: [:show, :index] do
    resources :units, only: [:show, :index, :new, :edit]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
