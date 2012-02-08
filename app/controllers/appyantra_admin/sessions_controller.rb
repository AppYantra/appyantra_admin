module AppyantraAdmin
  class SessionsController < Devise::SessionsController

    layout '/appyantra_admin/application'
    layout '/appyantra_admin/landing_page', only: [:new]

    before_filter(only: [:new]) { @page_title = 'Sign In'}
    
    private
    
    def after_sign_out_path_for(resource)
      if resource.is_a?(Admin)
        main_app.new_admin_session_path
      else
      # TODO make this configurable
        main_app.new_admin_session_path
      end
    end
    
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