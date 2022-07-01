Rails.application.routes.draw do
  devise_for :admins

  resources :admins

  # devise_for :admins, controllers: {
  #   sessions: 'users/sessions'
  # }

  # devise_scope :admin do
  #   # Redirests signing out users back to sign-in
  #   get "admins", to: "devise/sessions#new"
  # end

  # get 'classrooms/index'

  root "static_pages#home"

  # get 'sessions/new', as: "log_in"
  
  resources :students do
    member do
      get :profile
    end
    
    collection do
      post :search
    end
  end

  resources :students, only: [:show] do
    resources :terms do
      resources :student_terminal_subjects do
        collection do
          get "time_table", to: "student_terminal_subjects#time_table"
        end
      end
      resources :student_terminal_cocurriculums
    end
  end

  resources :subjects do
    collection do
      get "subjects-excel", to: "subjects#subjects_excel_sheet"
    end
  end

  resources :teachers do
    member do
      get "profile", to: "teachers#profile"
      get "workload", to: "teachers#workload"
    end
  end

  resources :classrooms do
    member do
      post :search_for_attendance
      post :search_for_timetable
    end
    collection do
      get "excel-sheet", to: "classrooms#excel_index"
    end
  end

  resources :student_terminal_subjects, only: [:show] do
    resources :marks_report
  end

  resources :cocurriculums
  
end
