Rails.application.routes.draw do
  resources :users

  root "staticpages#top"
  get "up" => "rails/health#show", as: :rails_health_check

end
