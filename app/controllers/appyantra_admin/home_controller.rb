module AppyantraAdmin
  class HomeController < ApplicationController
    before_filter(except: [:index]) { |c| c.authenticate_admin! }
    before_filter(except: [:index]) { |c| c.add_breadcrumb(['Home', main_app.root_url])}

    def index
      if admin_signed_in?
        @page_title = 'Home'
        add_breadcrumb([@page_title, main_app.root_url])
        current_breadcrumb 'Dashboard'
        @assets = ["Spot", "Food", "Place", "Address", "Event", "Activity"]
        @page_title = 'Home'
      else
        redirect_to main_app.new_admin_session_path
      end
    end

  end
end
