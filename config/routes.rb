Rails.application.routes.draw do

  devise_for :users, controllers: { passwords: 'users/passwords', sessions: 'users/sessions', registrations: 'signs' }

  
  # custom raoutes for qas and developers
  # get 'qa_dashboard', to: 'dashboards#qa_projects', as: 'qa_dashboard'
  # get 'qa_dashboard/qa_show/:project_id', to: 'dashboards#qa_show', as: 'qa_show'
  # get 'qa_show/:project_id/tasks/new', to: 'dashboards#qa_new', as: 'qa_new'


  # get 'developer_dashboard', to: 'dashboards#developer_projects', as: 'developer_dashboard'

  # get '/developer_dashboard/dev_show/:project_id', to: 'dashboards#developer_show', as: 'developer_show/'
  # namespace :dashboards do
  #   namespace :developer do
  #     get 'developer_dashboard', to: 'dashboard#developer_projects', as: 'developer_dashboard'
  #   end
  # end
  
  root "projects#index"

  resources :projects do 
    resources :tasks
  end

  # to update task for the developer
  # put 'update_task/:id', to: 'tasks#update', as: 'update_task'

  # error handling
  get '/404', to: 'public#404'
  get '/422', to: 'public#422'
  get '/500', to: 'public#500'
  match '*path', to: 'errors#not_found', via: :all
end
