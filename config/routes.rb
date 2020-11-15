Rails.application.routes.draw do
  # devise_for :users
  resources :timeslots
  resources :barbers do 
    resources :timeslots, only: [:index, :new]
  end
  resources :clients do 
    resources :barbers, only: [:index]
    resources :timeslots, only: [:index, :new]
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'clients#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
