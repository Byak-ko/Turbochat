Rails.application.routes.draw do
  resources :rooms do
    resources :messages
    member do
      get :manage_participants
      get :edit_participants
      patch :update_participants
      post :add_participant
      delete :remove_participant
    end
  end
  root 'pages#home'
  devise_for :users, controllers: {
    sesions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'user/:id', to: 'users#show', as: 'user'
  # Defines the root path route ("/")
  # root "articles#index"
end