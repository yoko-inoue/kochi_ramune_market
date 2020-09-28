Rails.application.routes.draw do
  #root 'items#index'
  root 'items#index'
  resources :items, only: [:new, :create]
  get  "/items/item_params" ,to: "items#item_params"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
