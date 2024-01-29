Rails.application.routes.draw do
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'chatrooms/find_chatroom_id', to: 'chatrooms#find_chatroom_id'
  get 'chat_histories/fetch_messages', to: 'chat_histories#fetch_messages'
  resources :chatrooms, only: [:new, :create, :destroy, :show]
  resources :chat_histories, only: [:create, :index]
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'chatroom/new', to: redirect('/')
  # Defines the root path route ("/")
  # root "posts#index"
  resources :chatrooms do
    collection do
      get 'index_custom'
    end
  end

  resources :chat_histories, only: [:index]

end
