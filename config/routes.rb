# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#top'

  resources :users, only: %i[new create]

  get 'login' => 'user_sessions#new'
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy'
end
