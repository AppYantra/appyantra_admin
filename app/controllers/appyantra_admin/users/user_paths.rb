module AppyantraAdmin
  module Users::UserPaths

    def after_sign_out_path_for(resource)
      main_app.root_path
    end

    def after_sign_in_path_for(resource)
      main_app.root_path
    end

    def after_inactive_sign_up_path_for(resource)
      main_app.root_path
    end

    def after_update_path_for(resource)
      main_app.root_path
    end

    def after_resending_confirmation_instructions_path_for(resource_name)
      main_app.root_path
    end

    def after_confirmation_path_for(resource_name, resource)
      main_app.root_path
    end

    def after_sending_reset_password_instructions_path_for(resource_name)
      main_app.root_path
    end

  end
end