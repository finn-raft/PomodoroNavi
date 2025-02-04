Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', passwords: 'users/passwords', omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :users,only: [:show]
  resources :navi_characters, only: [:new, :create, :edit, :update]

  root "staticpages#top"
  post 'openai_navis/respond', to: 'openai_navis#respond', as: :openai_navis_respond
  get "up" => "rails/health#show", as: :rails_health_check
end
