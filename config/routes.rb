Rails.application.routes.draw do
  resources :messages
  resources :users, only: [] do
    collection do
      get :whoami
    end
  end

  controller :auth do
    post :login
    post :register
  end
end
