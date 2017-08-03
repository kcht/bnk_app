Rails.application.routes.draw do
  root 'static_page#home'

  get 'home', to: 'static_page#home'
  get 'help', to: 'static_page#help'
  get 'about', to: 'static_page#about'
  get 'contact', to: 'static_page#contact'
  get  'signup',  to: 'users#new'
  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'users/last', to: 'users#last'
  resources :users

  get '/programs/tag/:tag_id', to: 'programs#index_tags', as: 'tagged_programs'
  get '/programs/all', to: 'programs#index_all', as: 'all_programs'
  post '/xx', to: 'programs#create'

  resources :programs, :songs

  root 'index', controller: :index, action: :index

  get 'search_results', to: 'songs#search'
  get 'songs_database', to: 'songs#songs_database'
  post 'songs_database', to: 'songs#songs_database'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
