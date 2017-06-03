Rails.application.routes.draw do
  get 'index', controller: :index

  root 'index', controller: :index, action: :show

  resources :programs

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
