Rails.application.routes.draw do
  scope "api" do
    scope "v1" do
      # Current User
      scope "user" do
        resources :user_details, except: %i[ index create update destroy ]
        put "/user_details" => "user_details#update"
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
