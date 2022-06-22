Rails.application.routes.draw do
  resources :searchs, only: %i[index create]
  root 'searchs#index'
end
