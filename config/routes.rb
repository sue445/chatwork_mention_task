Rails.application.routes.draw do
  resources :auth, only: [] do
    collection do
      get ":provider/callback", to: "auth#callback", constraints: { provider: /chatwork/ }
    end
  end

  resources :home, only: [:index]

  root to: "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
