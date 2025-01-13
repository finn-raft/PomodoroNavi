Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :users,only: [:show]

  root "staticpages#top"
  post 'openai_navis/respond', to: 'openai_navis#respond'
  get "up" => "rails/health#show", as: :rails_health_check
end
