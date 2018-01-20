Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1, defaults: { format: 'json' } do
      resources :wallets, only: %i[create show] do
        collection do
          post 'check-donation', to: 'wallets#check_donation'
        end
      end
    end
  end
  mount Raddocs::App => '/docs'
  root to: 'api/v1/uptime#show'
end
