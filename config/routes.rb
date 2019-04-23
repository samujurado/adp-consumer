Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'adp_client/index'
  get 'adp_client/connect'
  get 'adp_client/disconnect'
  get 'adp_client/workers'
  get 'adp_client/demographics'
  get 'adp_client/events'
  get 'adp_client/subscription'

  root 'adp_client#index'
end
