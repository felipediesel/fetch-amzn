Rails.application.routes.draw do
  resources :products

  root "page#index"
end
