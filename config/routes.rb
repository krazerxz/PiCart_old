Rails.application.routes.draw do

  get 'products', to: 'products#index'

  namespace :api do
    post 'products', to: 'products#create'
  end
end
