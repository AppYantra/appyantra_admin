module AppyantraAdmin
  class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      auth = request.env["omniauth.auth"]
      @user = User.find_for_facebook_oauth(auth)
      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
        sign_in_and_redirect @user, :event => :authentication
      else
        @user.first_name = auth["info"]["first_name"]
        @user.email = auth["info"]["email"]
        self.facebook_user = @user
        redirect_to new_user_registration_path
      end
    end

    def passthru
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end
  end
end
