# frozen_string_literal: true

Rails.application.routes.draw do
  apipie
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'
    namespace :v1 do
      resources :projects, except: %i[new show edit] do
        resources :tasks, except: %i[new show edit] do
          resources :comments, only: %i[index create destroy]
        end
        patch 'sort', to: 'tasks#sort'
      end
    end
  end
end
