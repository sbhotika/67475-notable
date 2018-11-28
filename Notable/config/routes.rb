Rails.application.routes.draw do
  get 'home/index'

  get "/", to: "editor#index"
end
