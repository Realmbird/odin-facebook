class SessionsController < ApplicationController
    def create
        # You can use request.env['omniauth.auth'] to get the authentication data
        @user = User.from_omniauth(request.env['omniauth.auth'])
        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: params[:provider].capitalize) if is_navigational_format?
        else
          session["devise.#{params[:provider]}_data"] = request.env['omniauth.auth'].except(:extra)
          redirect_to new_user_registration_url
        end
      end
    
      def failure
        # handle failure
        redirect_to root_path
      end
end
