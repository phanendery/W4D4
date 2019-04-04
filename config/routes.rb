Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :session, only:[:create,:new,:destroy]  #single resource because not in table
  resources :users
  resources :bands
end
