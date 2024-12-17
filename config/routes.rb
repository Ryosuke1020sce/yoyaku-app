Rails.application.routes.draw do
  devise_for :users
  
  root to: 'stores#index'  

  resources :stores do
    resources :reservations, only: [:new, :create, :show, :edit, :update, :destroy] do
      resources :guests, only: [:index, :create, :show]
    end
    resources :calendars, only: [:create, :show] do
      resources :rsv_groups, only: [:new, :create, :edit, :update]
      get 'guest_show', to: 'calendars#guest_show'
    end
  end

  get 'stores/new_copy/:id', to: 'stores#new_copy'
  patch 'stores_copy', to: 'stores#create_copy'

end
