Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', passwords: 'users/passwords', omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :users, only: [:show]
  resources :navi_characters, only: [:new, :create, :edit, :update]
  resources :pomodoro_sessions, only: [:create]

  root "staticpages#top"

  # ポモドーロタイマー設定ページを /pomodoro_settings で表示する
  get 'pomodoro_settings', to: 'pomodoro_settings#edit', as: :edit_pomodoro_settings
  patch 'pomodoro_settings', to: 'pomodoro_settings#update'
  get 'pomodoro_settings/show', to: 'pomodoro_settings#show', as: :show_pomodoro_settings
  get 'default_pomodoro_settings', to: 'pomodoro_settings#show_default' # デフォルトのポモドーロタイマー設定を参照するルーティング

  # レポートページのルーティング
  get 'report', to: 'pomodoro_sessions#reports', as: :report
  get 'report/day', to: 'pomodoro_sessions#reports_day', as: 'pomodoro_sessions_reports_day'
  get 'report/week', to: 'pomodoro_sessions#reports_week', as: 'pomodoro_sessions_reports_week'
  get 'report/month', to: 'pomodoro_sessions#reports_month', as: 'pomodoro_sessions_reports_month'
  get 'report/year', to: 'pomodoro_sessions#reports_year', as: 'pomodoro_sessions_reports_year'
  get 'report/calendar', to: 'pomodoro_sessions#reports_calendar', as: 'pomodoro_sessions_reports_calendar'

  # ナビキャラクターとのチャットを表示するルーティング
  post 'openai_navis/respond', to: 'openai_navis#respond', as: :openai_navis_respond
  get 'navi_messages/random', to: 'navi_messages#show_random_message', as: 'random_navi_message'
  get 'navi_messages/:id', to: 'navi_messages#show_specific_message', as: 'specific_navi_message'

  # ヘルスチェック用のルーティング
  get "up" => "rails/health#show", as: :rails_health_check
  get '/flycheck/vm', to: proc { [200, {}, ['OK']] }
end
