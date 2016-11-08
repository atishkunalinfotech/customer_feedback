Rails.application.routes.draw do
  resources :companies
  resources :towns
  resources :locations
  resources :industries
  resources :suppliers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
