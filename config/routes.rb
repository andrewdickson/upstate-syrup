UpstateSyrup::Application.routes.draw do
  resources :sites

  #root to: 'sites#index', as: 'home'

  get 'pages/home' => 'high_voltage/pages#show', id: 'home'

end
