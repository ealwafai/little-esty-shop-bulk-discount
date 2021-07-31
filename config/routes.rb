Rails.application.routes.draw do
  namespace :admin do
    resources :merchants
    resources :invoices
  end

  resources :admin, controller: 'admin/dashboard', only: [:index]

  resources :merchants, only: [:index] do
    resources :dashboard, only: [:index]
    resources :items
    resources :invoices, only: [:index, :show]
  end

  resources :admin, controller: 'admin/dashboard', only: [:index]

end
