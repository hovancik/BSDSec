Rails.application.routes.draw do
  root to: 'articles#index'
  resources :articles
  resources :tags
  mount_griddler
end
