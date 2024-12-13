Rails.application.routes.draw do
  devise_for :users
  
  root to: 'stores#index'  

  resources :stores do
    resources :reservations, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :rsv_groups, only: [:new, :create, :edit, :update]
    resources :calendars, only: [:index, :new, :create]
  end

  get 'stores/new_copy/:id', to: 'stores#new_copy'
  patch 'stores_copy', to: 'stores#create_copy'

end
