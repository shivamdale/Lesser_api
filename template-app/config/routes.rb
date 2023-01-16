Rails.application.routes.draw do
  get "/healthcheck", to: proc { [200, {}, ["Ok"]] }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :account_block, defaults: { format: :json } do
    resources :accounts
    resources :age_groups, only: :index
    resources :cities, only: :index
    resources :genders, only: :index
  end

  namespace :bx_block_login, defaults: { format: :json } do
    resources :logins
  end
end
