module AppyantraAdmin
  class Users::ConfirmationsController < Devise::ConfirmationsController

    layout 'application'

    before_filter(only: [:new]) { @page_title = 'Resend confirmation instructions'}

    helper AppyantraAdmin::ApplicationHelper

    private

    include AppyantraAdmin::Users::UserPaths

  end
end