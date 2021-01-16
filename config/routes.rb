Rails.application.routes.draw do
  resources :auth, only: [] do
    collection do
      get :sign_out
      get "chatwork/callback", to: "auth#callback"
    end
  end

  resources :home, only: [:index]

  resource :me, only: [:show, :edit, :update]

  resources :webhook, only: [] do
    collection do
      post "account/:account_id" => "webhook#account", as: :account
    end
  end

  root to: "home#index"

  mount KomachiHeartbeat::Engine => "/ops"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
