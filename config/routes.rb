require 'sidekiq/web'

Rails.application.routes.draw do
  root 'welcome#index'

  mount Sidekiq::Web, at: '/sidekiq'

  devise_for :users, controllers: { registrations: 'registrations' }

  devise_scope :user do
    get '/preview', to: 'registrations#show'
  end

  namespace :api do
    namespace :v1 do
      resource :auth_tokens, only: :create
      resource  :reports do
        collection do
          post :by_author
        end
      end

      scope module: 'author' do
        resources :posts, only: %i[index show create], param: :post_id
        resources :comments, only: %i[show create destroy], param: :comment_id
      end
    end
  end
end
