module AppyantraAdmin
  class PasswordsController < Devise::PasswordsController

    #layout '/appyantra_admin/application'
    layout "/appyantra_admin/landing_page"
    
    private
    
    def after_sending_reset_password_instructions_path_for(resource)
      if resource.is_a?(Admin)
        main_app.new_admin_session_path
      else
      # TODO make this configurable
        main_app.new_admin_session_path
      end
    end
    
    # TODO remove duplicate code (present in sessions controller also)
    def after_sign_in_path_for(resource)
      if resource.is_a?(Admin)
        main_app.appyantra_admin_home_path
      else
      # TODO error page
        main_app.appyantra_admin_home_path
      end
    end

  end
end