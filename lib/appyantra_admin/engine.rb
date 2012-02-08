module AppyantraAdmin
  class Engine < Rails::Engine
    isolate_namespace AppyantraAdmin
    
    config.action_mailer.default_url_options = { :host => 'localhost:3000' }
    config.to_prepare do
      ApplicationController.helper(ApplicationHelper)
      SessionsController.helper(ApplicationHelper)
      PasswordsController.helper(ApplicationHelper)
    end
  end
end
