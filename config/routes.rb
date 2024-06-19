Rails.application.routes.draw do
  devise_for :users
  root to: 'dashboards#show'
  get 'dashboard', to: 'dashboards#show'

  get 'dashboard/member_borrows', to: 'dashboards#member_borrows'
  get 'dashboard/all_borrows', to: 'dashboards#all_borrows'

  namespace :admin do
    resources :users
  end

  resources :borrows, only: [:create, :update] do
    member do
      put 'return_book'
    end
  end

  resources :books
end
