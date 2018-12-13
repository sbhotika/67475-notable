Rails.application.routes.draw do

  resource :note, only: [:create, :new]

  get 'notes/new'

  get 'notes/newnote'

  get 'home/index'

  get "/", to: 'home#index'

  get 'notes/transcribe', to: 'notes#transcribe', as: 'transcribe_note'
end
