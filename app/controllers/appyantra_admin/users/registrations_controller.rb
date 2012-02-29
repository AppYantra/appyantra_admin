module AppyantraAdmin
  class Users::RegistrationsController < Devise::RegistrationsController

    layout 'application'

    before_filter(only: [:new]) { @page_title = 'Sign Up'}
    before_filter(only: [:edit]) { @page_title = 'Update Account'}

    helper AppyantraAdmin::ApplicationHelper

    private

    include AppyantraAdmin::Users::UserPaths
    
  end
end