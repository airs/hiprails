Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'descriptor#index'

  resources :installations, only: [:create, :destroy]

  get 'glance' => 'addon#glance'
  post 'webhook' => 'addon#webhook'
end
