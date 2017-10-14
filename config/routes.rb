Rails.application.routes.draw do
  devise_for :users

  root 'welcome#index'

  namespace :api do
    namespace :v1 do
      resource :auth_tokens, only: :create

      scope module: 'author' do
        resources :posts, only: %i[index show create], param: :post_id
        resources :comments, only: %i[show create destroy], param: :comment_id
      end
    end
  end
end
