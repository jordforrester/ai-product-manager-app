Rails.application.routes.draw do
  get "prds/new"
  get "prds/create"
  get "prds/show"
  devise_for :users
  
  authenticated :user do
    root 'pages#dashboard', as: :authenticated_root
  end

  resources :product_ideas do
    resources :prds do
      member do
        get :generating
        get :check_status
      end
    end
  end


  
  root 'pages#home'
  get 'dashboard', to: 'pages#dashboard'
  
  resources :product_ideas
  get "product_ideas/index"
  get "product_ideas/show"
  get "product_ideas/new"
  get "product_ideas/create"
  get "product_ideas/edit"
  get "product_ideas/update"
  get "product_ideas/destroy"
end
