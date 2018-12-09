Rails.application.routes.draw do

  resource :note, only: [:create, :new]
  
  get 'notes/new'

  get 'home/index'

  get "/", to: "editor#index"
end
