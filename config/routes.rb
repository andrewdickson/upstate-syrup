KraegerSyrup::Application.routes.draw do
  get '/' => 'high_voltage/pages#show', id: 'home'
  get '/about' => 'high_voltage/pages#show', id: 'about'
  get '/contact' => 'high_voltage/pages#show', id: 'contact'
end
