Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'signs' }

  # custom raoutes for qas and developers
  get 'qa_dashboard', to: 'dashboards#qa', as: 'qa_dashboard'
  get 'developer_dashboard', to: 'dashboards#developer', as: 'developer_dashboard'
  
  root "projects#index"

  resources :projects do 
    resources :tasks
  end

  # to update task for the developer
  put 'update_task/:id', to: 'tasks#update', as: 'update_task'
end
