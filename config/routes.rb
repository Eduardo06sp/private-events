Rails.application.routes.draw do
  devise_for :users, controllers: { session: 'users/sessions' }
  devise_scope :user do
    get '/users/:id' => 'users/sessions#show'
  end

  resources :events, only: [:index]
  root to: 'events#index'
end
