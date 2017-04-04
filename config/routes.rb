Rails.application.routes.draw do

  resources :items, param: :name
  resources :heroes, param: :name do
    resources :abilities
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
