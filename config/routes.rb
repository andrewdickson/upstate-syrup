KraegerSyrup::Application.routes.draw do
  root to: 'home#home'
  get '/' => 'home#home', as: 'home'
  get '/about' => 'home#about', as: 'about'
  get '/contact' => 'home#contact', as: 'contact'
  post '/create_message' => 'home#create_message', as: 'create_message'
end
