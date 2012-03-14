module AppyantraAdmin
  class Engine < Rails::Engine
    isolate_namespace AppyantraAdmin
    
    config.to_prepare do
      ApplicationController.helper(ApplicationHelper)
      SessionsController.helper(ApplicationHelper)
      PasswordsController.helper(ApplicationHelper)
    end

    # ensure that sweepers are loaded
    config.autoload_paths << "#{config.root}/app/appyantra_admin/sweepers"

    # register record observers
    config.active_record.observers = :activity_log_observer
  end
end
