Rails.application.routes.draw do
  root 'static_page#home'
  get 'static_page/home'

  get 'static_page/help'
  get 'static_page/about'

  resources :users

  resources :programs, :songs

  root 'index', controller: :index, action: :index

  get 'search_results', to: 'songs#search'
  get 'songs_database', to: 'songs#songs_database'
  post 'songs_database', to: 'songs#songs_database'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
