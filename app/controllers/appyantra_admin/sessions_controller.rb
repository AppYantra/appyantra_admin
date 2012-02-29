module AppyantraAdmin
  class SessionsController < Devise::SessionsController

    layout '/appyantra_admin/application'
    layout '/appyantra_admin/landing_page', only: [:new]

    before_filter(only: [:new]) { @page_title = 'Sign In'}
    
    private

    def after_sign_out_path_for(resource)
      main_app.new_admin_session_path
    end

    def after_sign_in_path_for(resource)
      main_app.appyantra_admin_home_path
    end
    
  end
end