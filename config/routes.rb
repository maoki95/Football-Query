# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'top#top'

  get 'login' => 'user_sessions#new'
  post 'login' => 'user_sessions#create'
  delete 'logout' => 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resources :questions do
    resources :answers, only: %i[create destroy], shallow: true
  end
  resource :profile, only: %i[show edit update]
end
