Photastic::Application.routes.draw do

  resources :albums do
    member do
      post 'promote'
    end
    resources :pictures, except: [:edit, :update] do
      resources :comments, except: [:index, :new, :edit, :update]
    end
    resources :passcodes, only: [:new, :create]
    resources :members
  end

  devise_for :users

  root :to => 'albums#index'
end
