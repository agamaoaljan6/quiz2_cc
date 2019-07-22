Rails.application.routes.draw do
  get '/', { to: 'ideas#index', as: 'root' }

  resources :users, only: [:new, :create, :edit, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :ideas do 
    resources :reviews, only: [:create, :destroy]
  end 

end
