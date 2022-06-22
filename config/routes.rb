Rails.application.routes.draw do
  resources :parkings, only: %i[index]
  root 'parkings#index'
end
