Rails.application.routes.draw do
  scope "api" do
    scope "v1" do
      # Current User
      scope "users" do
        get "user_info", to: "users/users#user_info"
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
