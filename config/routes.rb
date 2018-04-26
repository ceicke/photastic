Photastic::Application.routes.draw do

  resources :albums do
    member do
      post 'promote'
    end
    resources :pictures do
      resources :comments, except: [:index, :new, :edit, :update]
    end
    resources :videos do
      resources :comments, except: [:index, :new, :edit, :update]
    end
    resources :search, only: [:create]
    resources :passcodes, only: [:new, :create]
    resources :album_members
  end
  resources :users, only: [:edit, :update]
  resource :video_callback, only: [:callback] do
    member do
      get 'callback'
    end
  end

  devise_for :users
  get '/', to: 'pictures#index', constraints: { :subdomain => /.+/ }
  root :to => 'albums#index'
end
