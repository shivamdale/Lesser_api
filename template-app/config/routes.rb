Rails.application.routes.draw do
  get "/healthcheck", to: proc { [200, {}, ["Ok"]] }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :account_block, defaults: { format: :json } do
    delete 'delete_user', to: 'accounts#delete_user'
    put 'edit_profile', to: 'accounts#edit_profile'
    get 'get_details', to: 'accounts#get_details'
    resources :accounts
    resources :age_groups, only: :index
    resources :cities, only: :index
    resources :genders, only: :index
  end

  namespace :bx_block_login, defaults: { format: :json } do
    resources :logins
  end

  namespace :bx_block_dashboard, defaults: { format: :json } do
    resources :recycle_bottles
    resources :bottle_deposit_details
  end
  namespace :bx_block_forgot_password do
    resources :otps, only: %i(create)
    resources :otp_confirmations, only: %i(create)
    resources :passwords, only: %i(create)
  end

  namespace :bx_block_profile do
    put "passwords", to:'passwords#update'
    resources :profiles, only: %i(show update)
  end

  namespace :bx_block_level do
    resources :account_levels
  end

  namespace :bx_block_push_notifications do
    resources :push_notifications
  end
end
