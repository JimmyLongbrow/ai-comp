Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pages#welcome'
  get '/home' => 'pages#welcome'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'
  get '/users/edit' => 'users#edit'
  post '/users/edit' => 'users#show'
  resources :users do
    member do
      get :confirm_email
    end
  end
  resources :recordings
  resources :sequences
end
