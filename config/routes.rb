Rails.application.routes.draw do
  resources :applications, param: :token, only: %i[create update show] do
    resources :chats, param: :number, only: %i[create update show] do
      resources :messages, param: :number, only: %i[create update show]
    end
  end
end
