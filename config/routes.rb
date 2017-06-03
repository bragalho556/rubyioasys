Rails.application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      namespace :auth do
        post 'sign_in' => 'sessions#create'
        delete 'sign_out' => 'sessions#destroy'
      end
      # models auth
      resources :users, except: [:edit, :new, :index, :destroy], shallow: true do
        member do
          put :password
          put :register_device
        end
        collection do
          namespace :auth do
            put 'omniauth/:provider' => 'omniauth#all'
            patch 'omniauth/:provider' => 'omniauth#all'
          end
          post :reset_password
        end
      end
      resources :companies, only: [:index, :show]
    end
  end


  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
