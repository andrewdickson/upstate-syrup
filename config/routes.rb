KraegerSyrup::Application.routes.draw do
  resources :reviews


  resources :slide_show_items

  get '/pictures' => 'slide_show_items#index', as: 'pictures'
  get '/pictures/:id/edit' => 'slide_show_items#edit', as: 'edit_picture'
  get '/pictures/new' => 'slide_show_items#new', as: 'new_picture'

  root to: 'home#home'
  get '/' => 'home#home', as: 'home'
  get '/about' => 'home#about', as: 'about'
  get '/contact' => 'home#contact', as: 'contact'
  post '/create_message' => 'home#create_message', as: 'create_message'

  post '/update_settings' => 'slide_show_items#settings', as: 'update_settings'
end
