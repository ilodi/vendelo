Rails.application.routes.draw do
  post '/products', to: 'products#create'
  #el path(helper o as:) es para ayudar en las url a ser mas humanas
  get '/products/new', to: 'products#new', as: :new_product
  get '/products', to: 'products#index'
  #as crea un helper para identificar mejor la url
  get '/products/:id', to: 'products#show', as: :product
end
