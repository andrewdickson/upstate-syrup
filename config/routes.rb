KraegerSyrup::Application.routes.draw do
  resources :zones


  resources :products


  devise_for :users

  resources :reviews
  resources :slide_show_items
  resources :messages

  get '/pictures' => 'slide_show_items#index', as: 'pictures'
  get '/pictures/:id/edit' => 'slide_show_items#edit', as: 'edit_picture'
  get '/pictures/new' => 'slide_show_items#new', as: 'new_picture'



  root to: 'home#home'
  get '/' => 'home#home', as: 'home'
  get '/about' => 'home#about', as: 'about'
  get '/contact' => 'home#contact', as: 'contact'


  get '/admin' => 'admin#index', as: 'admin'
  get '/admin/new' => 'admin#new', as: 'new_admin'
  post '/admin/create' => 'admin#create', as: 'create_admin'
  get '/admin/content' => 'admin#content', as: 'content'
  post '/update_settings' => 'admin#update', as: 'update_settings'

  get '/change_password' => 'passwords#edit', as: 'change_password'
  put '/change_password' => 'passwords#update'

end
