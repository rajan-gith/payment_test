Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'billing#index', as: 'billing'
  # get '/card/new' => 'billing#new_card', as: :add_payment_method
  # post "/card" => "billing#create_card", as: :create_payment_method
  # get '/success' => 'billing#success', as: :success
  # post '/subscription' => 'billing#subscribe', as: :subscribe



  # get 'charges/new', to: 'charges#new'
  # post 'charges', to: 'charges#create', as: 'create_charges'
  root 'wallet#index'
  get 'wallet/add_amount', to: 'wallet#new', as: 'new_wallet_amount'
  get '/card/new' => 'wallet#new_card', as: 'add_card'
  patch 'wallet/add_amount', to: 'wallet#add', as: 'add_wallet_amount'

  get 'subscribe', to: 'subscribes#new', as: 'subscribe'
  get 'subscribe/recharge', to: 'subscribes#recharge', as: 'recharge_my_account'
end
