Rails.application.routes.draw do
  root to: 'clusters#index'
  resources :comments, only: [:create, :index] do
    member do
      put :dig
    end
  end
  resources :clusters, only: [:index] do
    collection do
      post :index
    end
  end
  resources :posts, only: [:create, :index, :show, :new]
  resources :articles, only: [:create, :show, :new]
  resources :users, only: [:create, :new] do
    collection do
      get :not_authenticated
      post :sign_in
      get :sign_out
    end
  end
end
