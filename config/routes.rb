Rails.application.routes.draw do
  resources :webhook, only: [] do
    collection do
      post "account/:account_id" => "webhook#account", as: :account
    end
  end

  resources :auth, only: [] do
    collection do
      get :sign_in, to: redirect("/auth/chatwork")
      get :sign_out
      get "chatwork/callback", to: "auth#callback"
    end
  end

  resources :home, only: [:index]

  resources :me, only: [:index] do
    collection do
      get :edit
      put :update
    end
  end

  root to: "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
