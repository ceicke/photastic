Photastic::Application.routes.draw do
  resources :albums


  devise_for :users

  root :to => 'albums#index'
end
