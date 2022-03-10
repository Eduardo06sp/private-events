Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get '/users/:id' => 'users/sessions#show'
    get '/users/sign_in' => 'users/sessions#create'
    post '/users/sign_out' => 'users/sessions#destroy'
  end

  resources :events, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :invitations, only: [:create, :destroy]
  root to: 'events#index'
end
