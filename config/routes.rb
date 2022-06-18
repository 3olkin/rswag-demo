Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  constraints format: :json do
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
end
