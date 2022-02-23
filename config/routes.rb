Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  devise_scope :user do
    get '/users/:id' => 'users/sessions#show'
  end

  resources :events, only: [:index, :new, :create, :show]
  resources :invitations, only: :create
  root to: 'events#index'
end
