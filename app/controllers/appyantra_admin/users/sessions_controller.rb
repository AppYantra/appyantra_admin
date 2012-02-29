module AppyantraAdmin
  class Users::SessionsController < Devise::SessionsController

    layout 'application'

    before_filter(only: [:new]) { @page_title = 'Sign In' }

    helper AppyantraAdmin::ApplicationHelper

    private

    include AppyantraAdmin::Users::UserPaths
    
  end
end