Rails.application.routes.draw do
  devise_for :users, controllers: { session: 'users/sessions' }
  devise_scope :user do
    get '/users/:id' => 'users/sessions#show'
  end

  get 'events/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'events#index'
end
