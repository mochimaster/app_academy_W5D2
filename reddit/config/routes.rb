Rails.application.routes.draw do

  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, only: :new
  end
  resources :posts, except: [:index, :new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
