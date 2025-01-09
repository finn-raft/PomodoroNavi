Rails.application.routes.draw do
  devise_for :users
  resources :users

  root "staticpages#top"
  post 'openai_navis/respond', to: 'openai_navis#respond'
  get "up" => "rails/health#show", as: :rails_health_check

end
