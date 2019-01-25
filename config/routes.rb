Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "application#welcome"

  post 'users' =>  'users#create'
  get 'login' => 'users#login'
  get 'logout' => 'users#logout'
end
