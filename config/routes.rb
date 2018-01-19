Rails.application.routes.draw do
  resources :auth, only: [] do
    collection do
      get :signin, to: redirect("/auth/chatwork")
      get "chatwork/callback", to: "auth#callback"
    end
  end

  resources :home, only: [:index]

  resources :my, only: [:index]

  root to: "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
