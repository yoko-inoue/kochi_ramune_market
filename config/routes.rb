Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
    get 'sending_destinations', to: 'users/registrations#new_sending_destination'
    post 'sending_destinations', to: 'users/registrations#create_sending_destination'
  end
  get '/users', to: redirect("/users/sign_up")

  root 'items#index'
  resources :items, only: [:new, :create,:show]
  namespace :api do
    resources :categories, only: :index, defaults: { format: 'json' }
  end
  # get  "/items/item_params" ,to: "items#item_params"
  resources :users, only: [:show, :edit]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html 
  resources :card, only: [:new, :show, :delete] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
      get 'require_make_card', to: 'cards#require_make_card'
    end
  end
end
