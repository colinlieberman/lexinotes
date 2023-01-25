Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/login', to: 'login#prompt'
  post '/login', to: 'login#login'
  get '/logout', to: 'login#logout'

  resources :notes, only: %i[index show create update delete]

  root to: 'notes#index'
end
