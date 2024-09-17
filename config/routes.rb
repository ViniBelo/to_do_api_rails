Rails.application.routes.draw do
  get "current_user/index"
  scope "api" do
    scope "v1" do
      # Current User
      scope "user" do
        get "current_user", to: "current_user#index"
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
