Rails.application.routes.draw do
  root('static_pages#home')
  get('/help', to: 'static_pages#help')
  get('/about', to: 'static_pages#about')
  get('/contact', to: 'static_pages#contact')
  get('/sign_up', to: 'users#new')
  post('/sign_up', to: 'users#create')
  get('/log_in', to: 'sessions#new')
  post('/log_in', to: 'sessions#create')
  delete('/log_out', to: 'sessions#destroy')
  get('/account_activate', to: 'account_activations#activate')

  resources(:users, only: [:index, :show, :edit, :update, :destroy]) do
    member do
      get(:followings, :followers)
    end
  end
  resources(:password_resets, only: [:new, :create, :edit, :update])
  resources(:microposts, only: [:create, :destroy])
  resources(:relationships, only: [:create, :destroy])
end
