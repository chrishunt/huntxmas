Xmaslist::Application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :sessions

  resources :users do
    resources :gifts
  end

  get 'users/:user_id/gifts/:id/purchase' => 'gifts#purchase', as: :purchase_user_gift
  get 'users/:user_id/gifts/:id/return'   => 'gifts#return',   as: :return_user_gift

  get 'login'  => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  get 'boomtown' => 'boomtown#boomtown'

  root to: 'users#index'
end
