Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
get 'shipments/request', to: 'shipments#request', as: 'request'
get 'shipments/response', to: 'shipments#response', as: 'response'
end
