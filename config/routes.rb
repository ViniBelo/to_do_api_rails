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
      resources :contexts, only: %i[ index show create update destroy ] do
        # Categories
        resources :categories, only: %i[ create ]
        # Tasks
        resources :tasks, only: %i[ index show create update destroy ]
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
