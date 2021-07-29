Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :merchants
    resources :invoices
  end

  resources :merchants do
    resources :items
  end

  resources :admin, controller: 'admin/dashboard', only: [:index]

end
