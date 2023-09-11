Rails.application.routes.draw do
  devise_for :users
  # get 'tasks/index'
  # get 'users/index'

  root "projects#index"

  resources :projects do 
    resources :tasks
  end
  resources :users
end
