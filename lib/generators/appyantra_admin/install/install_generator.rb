class AppyantraAdmin::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  desc "Creates an AppyantraAdmin initializer and copies related files to your application."

  def install
    #copy_initializer
    template "appyantra_admin.rb", "config/initializers/appyantra_admin.rb"
    puts "Copying migrations..."
    copy_migrations
    add_appyantra_admin_routes
    puts "After running the migrations, you need to do the following: "
    puts "(1) Modify the initializer configurations --> config/initializers/appyantra_admin.rb"
    puts "(2) Run Migrations"
    puts "(3) Create an admin user by running:"
    puts "rake appyantra_admin:create_admin email='EMAIL' first_name='FIRST_NAME' last_name='LAST_NAME'"
    puts "(4) Create basic application settings by running:"
    puts "rake appyantra_admin:setup_admin"
    puts "(5) Delete public/index.html"
  end

  private

  def add_appyantra_admin_routes
    appyantra_admin_route = %Q{mount AppyantraAdmin::Engine => "/appyantra_admin"}
    appyantra_admin_route << "\n  "
    appyantra_admin_route << %Q{root :to => 'appyantra_admin/home#website'}
    route appyantra_admin_route
  end

  def copy_migrations
    %x[rake appyantra_admin:install:migrations]
  end
end
