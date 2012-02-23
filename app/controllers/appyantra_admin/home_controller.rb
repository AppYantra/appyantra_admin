module AppyantraAdmin
  class HomeController < ApplicationController
    before_filter(except: [:index, :website]) { |c| c.authenticate_admin! }
    before_filter(except: [:index]) { |c| c.add_breadcrumb(['Home', main_app.root_path])}

    def index
      if admin_signed_in?
        @page_title = 'Home'
        add_breadcrumb([@page_title, main_app.root_path])
        current_breadcrumb 'Dashboard'
        @assets = AppyantraAdmin.assets
        @page_title = 'Home'
      else
        redirect_to main_app.new_admin_session_path
      end
    end

    def website
      render '/website/index', layout: 'application'
    end

  end
end
