Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      # Current User
      scope :user do
        scope :user_details do
          get "/" => "user_details#show"
          patch "/" => "user_details#update"
        end
      end

      # Contexts
      resources :contexts, only: [ :index, :create ] do
        # Tasks
        resources :tasks, only: [ :index, :create ]
      end

      # Users
      devise_for :users, path_names: {
        sign_in: "login",
        sign_out: "logout",
        registration: "signup"
      },
      controllers: {
        sessions: "users/sessions",
        registrations: "users/registrations"
      }
    end
  end
end
