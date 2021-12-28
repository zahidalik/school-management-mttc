Rails.application.routes.draw do
  get 'classrooms/index'
  root "static_pages#home"
  get 'sessions/new', as: "log_in"
  resources :students
  resources :students, only: [:show] do
    resources :terms do
      resources :student_terminal_subjects
    end
  end
  resources :subjects
  resources :teachers
  resources :classrooms
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
