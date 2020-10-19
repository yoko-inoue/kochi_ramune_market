Rails.application.routes.draw do
  get 'bookmarks/create'
  get 'bookmarks/destroy'
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
  resources :items do
    member do
      # get "purchase_confirmation"
      get 'buycheck'
      post "purchase"
    end
    collection do
      # get 'buycheck'
      get 'get_category_child', to: 'items#get_category_child', defaults: { format: 'json' }
      get 'get_category_grandchild', to: 'items#get_category_grandchild', defaults: { format: 'json' }
    end
    resource :bookmarks, only: [:create, :destroy]
  end
  namespace :api do
    resources :categories, only: :index, defaults: { format: 'json' }
  end
  # get  "/items/item_params" ,to: "items#item_params"
  resources :users, only: [:show, :edit] do
    get :bookmarks, on: :collection
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html 
  resources :cards, only: [:index, :new, :create, :destroy] 
  resources :searches, only:[:index]
end
