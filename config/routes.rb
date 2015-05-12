Rails.application.routes.draw do

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  resources :videos do
    resources :comments
    get 'json' => 'videos#json_url_and_comments', as: 'json'

  end
  resource :session, :only => [:new, :create, :destroy]
  resources :users, :except => [:destroy]
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      post :mark_as_read
    end
  end
  resources :messages, only: [:new, :create]

  get '/comments/new/(:parent_id)', to: 'comments#new', as: :new_comment

  get 'signin' => 'sessions#new', as: 'signin'
  get 'signout' => 'sessions#destroy', as: 'signout'
  get 'signup' => 'users#new', as: 'signup'

  get 'search' => 'search#new', as: 'search'

  root 'welcome#index'

end
