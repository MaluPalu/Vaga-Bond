Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#index'

  get '/users/new', to: 'users#new', as: 'new_users'
  post '/users', to: 'users#create'
  get '/users/:id', to: 'users#show', as: 'user'
  get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  patch '/users/:id', to: 'users#update'

  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  post '/sessions', to: 'sessions#create'


  # In the future, you can nest the below routes like so:
  # resources :cities do
  #   resources :posts
  # end

  # I wouldn't do for this project, as you'll need to change your controller code
  # Resource: http://guides.rubyonrails.org/routing.html#nested-resources

  get '/posts/:id', to: 'posts#show', as: 'post'

  get '/cities', to: 'cities#index', as: 'city'
  get '/cities/:city_id', to: 'cities#show'
  get '/cities/:city_id/posts/new', to: 'posts#new', as: 'posts'
  post '/cities/:city_id/posts', to: 'posts#create'
  get '/cities/:city_id/posts/:post_id/edit', to: 'posts#edit', as: 'edit_post'
  patch '/cities/:city_id/posts/:post_id', to: 'posts#update', as: 'update_post'
  get '/cities/:city_id/posts/:post_id', to: 'posts#show', as: 'show_city_post'
  delete '/posts/:post_id', to: 'posts#destroy', as: 'destroy_post'
end
