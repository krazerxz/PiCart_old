Rails.application.routes.draw do
  namespace :api do
    resources :barcodes
  end
end
