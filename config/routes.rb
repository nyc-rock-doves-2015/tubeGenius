Rails.application.routes.draw do

  resources :videos do
    resources :comments, :only => [:show, :new, :create]
    get 'json' => 'videos#json_comments', as: 'json'
    resources :comments

  end

  resource :session, :only => [:new, :create, :destroy]
  resources :users, :except => [:destroy]

  get 'signin' => 'sessions#new', as: 'signin'
  get 'signout' => 'sessions#destroy', as: 'signout'
  get 'signup' => 'users#new', as: 'signup'

end
