Photastic::Application.routes.draw do

  resources :albums, except: :show do
    resources :pictures
  end

  devise_for :users

  root :to => 'albums#index'
end
