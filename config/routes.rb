Rails.application.routes.draw do
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'
    namespace :v1 do
      resources :projects do
        resources :tasks do
          resources :comments
        end
        post 'sorting', to: 'tasks#sorting'
      end
    end
  end
end