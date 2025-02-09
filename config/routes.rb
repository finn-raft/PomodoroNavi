Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', passwords: 'users/passwords', omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :users, only: [:show]
  resources :navi_characters, only: [:new, :create, :edit, :update]
  resources :pomodoro_sessions, only: [:index]

  # ポモドーロタイマー設定ページを /pomodoro_settings で表示する
  get 'pomodoro_settings', to: 'pomodoro_settings#edit', as: :edit_pomodoro_settings
  patch 'pomodoro_settings', to: 'pomodoro_settings#update'
  get 'pomodoro_settings/show', to: 'pomodoro_settings#show', as: :show_pomodoro_settings
  get 'default_pomodoro_settings', to: 'pomodoro_settings#show_default' # デフォルトのポモドーロタイマー設定を参照するルーティング

  root "staticpages#top"
  post 'openai_navis/respond', to: 'openai_navis#respond', as: :openai_navis_respond
  get 'report', to: 'pomodoro_sessions#reports', as: :report
  get "up" => "rails/health#show", as: :rails_health_check
end
