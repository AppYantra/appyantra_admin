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
end
