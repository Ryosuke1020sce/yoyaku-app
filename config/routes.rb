Rails.application.routes.draw do
  devise_for :users
  
  root to: 'stores#index'  

  resources :stores do
    get 'select_month', to: 'stores#select_month'
    resources :reservations, only: [:new, :create, :show, :edit, :update, :destroy] do
      resources :guests, only: [:index, :create, :show]
      get 'complete/:id', to: 'guests#complete'
    end
    resources :calendars, only: [:create, :show] do
      get 'disp_list', to: 'calendars#disp_list'
      resources :rsv_groups, only: [:new, :create, :edit, :update]
      get 'guests_show', to: 'calendars#guests_show'
      post 'guests_confirm', to: 'calendars#guests_confirm'
      get 'guests_search', to: 'calendars#guests_search'
    end
  end

  get 'stores/new_copy/:id', to: 'stores#new_copy'
  patch 'stores_copy', to: 'stores#create_copy'

end
