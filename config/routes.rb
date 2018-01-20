Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1, defaults: { format: 'json' } do
      resources :atms, only: %i[create] do
        member do
          post 'deposit'
          get 'withdraw'
        end
      end
      resources :banknotes, only: %i[create]
    end
  end
  mount Raddocs::App => '/docs'
  root to: 'api/v1/uptime#show'
end
