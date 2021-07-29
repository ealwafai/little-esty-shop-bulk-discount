Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :merchants
    resources :invoices
    resources :dashboard, only: [:index]
  end

  resources :merchants do
    resources :items
  end

end
