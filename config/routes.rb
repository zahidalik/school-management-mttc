Rails.application.routes.draw do
  root "static_pages#home"
  get 'sessions/new', as: "log_in"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
