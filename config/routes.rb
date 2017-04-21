Rails.application.routes.draw do

  resources :items, param: :name
  resources :heroes, param: :name do
    resources :abilities, param: :hotkey
  end
  get '/builds/', to: 'builds#make'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
