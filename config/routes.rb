Rails.application.routes.draw do
  get 'index', controller: :index

  resources :programs

  root 'index', controller: :index, action: :index

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
