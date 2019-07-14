Rails.application.routes.draw do
  resources :posts, only: [:create, :index, :show]
  resources :users, only: [:create, :new] do
    collection do
      get :not_authenticated
      post :sign_in
      delete :sign_out
    end
  end
end
