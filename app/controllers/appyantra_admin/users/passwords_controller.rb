module AppyantraAdmin
  class Users::PasswordsController < Devise::PasswordsController

    layout 'application'

    before_filter(only: [:edit]) { @page_title = 'Change your password'}
    before_filter(only: [:new]) { @page_title = 'Forgot your password?'}

    helper AppyantraAdmin::ApplicationHelper

    private

    include AppyantraAdmin::Users::UserPaths

  end
end