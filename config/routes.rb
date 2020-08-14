Rails.application.routes.draw do
  get 'resumes/index' => 'resume#show'
  get 'resumes/new' => 'resume#new'
  get 'resumes/create' => 'resume#create'
  get 'resumes/destroy' => 'resume#destroy'
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
  get '/sequences/:id/download' => 'sequences#download', as: 'sequence_download'
  resources :resumes, only: [:index, :new, :create, :destroy]
end
