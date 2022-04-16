Rails.application.routes.draw do
  get 'classrooms/index'
  root "static_pages#home"
  get 'sessions/new', as: "log_in"
  resources :students do
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
