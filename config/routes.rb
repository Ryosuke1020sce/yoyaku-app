Rails.application.routes.draw do
  devise_for :users
  
  root to: 'stores#index'  

  resources :stores, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  get 'stores/new_copy/:id', to: 'stores#new_copy'
  patch 'stores_copy', to: 'stores#create_copy'

end
