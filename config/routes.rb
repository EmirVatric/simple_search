Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'search#index'
  post 'search' => 'search#search'
  get 'dashboard' => 'statistics#index', as: 'dashboard'
end
