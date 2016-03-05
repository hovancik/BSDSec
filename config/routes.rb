Rails.application.routes.draw do
  get 'static_pages/about'
  get '/about' => 'static_pages#about'
  root to: 'articles#index'
  resources :articles
  resources :tags
  mount_griddler
end
