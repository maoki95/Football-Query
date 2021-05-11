# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'top#top'

  get 'login' => 'user_sessions#new'
  post 'login' => 'user_sessions#create'
  delete 'logout' => 'user_sessions#destroy'

  get 'inquiry' => 'inquiries#index'              # 入力画面
  post 'inquiry/confirm' => 'inquiries#confirm'   # 確認画面
  post 'inquiry/thanks' => 'inquiries#thanks'     # 送信完了画面

  get 'privacy_policy' => 'terms#privacy_policy'
  get 'terms_of_use' => 'terms#terms_of_use'

  get 'use' =>'use#use'

  resources :users, only: %i[new create index]
  resources :questions do
    resources :answers, only: %i[create destroy], shallow: true
  end
  resource :profile, only: %i[show edit update]
end
