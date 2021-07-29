Rails.application.routes.draw do
  resources :merchants do
    resources :invoices, only: [:index, :show]
  end
end
