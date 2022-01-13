Rails.application.routes.draw do
  get 'classrooms/index'
  root "static_pages#home"
  get 'sessions/new', as: "log_in"
  resources :students
  resources :students, only: [:show] do
    resources :terms do
      resources :student_terminal_subjects do
        collection do
          get "time_table", to: "student_terminal_subjects#time_table"
        end
      end
    end
  end

  resources :subjects do
    collection do
      get "subjects-excel", to: "subjects#subjects_excel_sheet"
    end
  end
  resources :teachers do
    member do
      get "workload", to: "teachers#workload"
    end
  end
  resources :classrooms do
    collection do
      get "excel-sheet", to: "classrooms#excel_index"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
