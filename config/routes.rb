Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :users
  end

  get 'dashboard/librarian', to: 'dashboards#librarian'
  get 'dashboard/member', to: 'dashboards#member'
  root to: 'dashboards#show'
end
