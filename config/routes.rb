Rails.application.routes.draw do
  devise_for :users, views: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create], as: :posts do
      resources :comments, only: %i[new create]
      resources :likes, only: %i[create]
    end
  end
  # Defines the root path route ("/")
  root to: 'users#index'
end
