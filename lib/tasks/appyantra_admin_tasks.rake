namespace :appyantra_admin do

  desc "Creates an admin user"
  task :create_admin => :environment do
    user_params = { first_name: ENV['first_name'], last_name: ENV['last_name'], email: ENV['email'] }
    admin_user = Admin.new(user_params)
    puts "Enter password"
    admin_user.password = $stdin.gets.chomp
    puts "Confirm password"
    admin_user.password_confirmation = $stdin.gets.chomp
    admin_user.save(:validate => false)
  end

  desc "Creates some basic settings"
  task :setup_admin => :environment do
    website_url = Link.create(name: 'website_url', text: 'Visit Website',
                              href: '#', title: 'Website URL')
    site_name = Text.create(name: 'site_name', value: 'Acme Company')
    copyright_year = Text.create(name: 'copyright_year', value: Time.now.year.to_s)
    puts 'Creating Website URL setting...'
    AdminSetting.create_from_entity(website_url.name, website_url)
    puts 'Creating Site Name setting...'
    AdminSetting.create_from_entity(site_name.name, site_name)
    puts 'Creating Copyright Year setting...'
    AdminSetting.create_from_entity(copyright_year.name, copyright_year)
  end

  desc "Adds a setting for Rich Text Editor and defaults it to CKEditor"
  task :use_rich_text_editor => :environment do
    rich_text_editor = Text.create(name: 'rich_text_editor', value: 'ckeditor')
    AdminSetting.create_from_entity(rich_text_editor.name, rich_text_editor)
  end
end
