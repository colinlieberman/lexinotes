Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/login', to: 'login#prompt'
  post '/login', to: 'login#login'

  resources :notes, only: %i[index show create update delete]

  root to: 'notes#index'
end
