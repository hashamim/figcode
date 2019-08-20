Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :new]
  resource :session, only: [:create, :destroy, :new]
  resources :messages, only: [:create, :new]
  root to: "users#new"
end
