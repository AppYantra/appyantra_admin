$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "appyantra_admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "appyantra_admin"
  s.version     = AppyantraAdmin::VERSION
  s.authors     = ["Govind Naroji"]
  s.email       = ["govind.naroji@gmail.com"]
  s.homepage    = "http://github.com/appyantra/appyantra_admin"
  s.summary     = %Q{Rails 3 engine for managing an app's assets, users, pages, blog, SEO and Social Media Integration }
  s.description = %Q{Rails 3 engine for managing an app's assets, users, pages, blog, SEO and Social Media Integration }

  s.files       = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test/**/*`.split("\n")

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency 'warden'
  s.add_dependency 'haml-rails'
  s.add_dependency 'devise', '~>1.5.3'
  s.add_dependency 'formtastic', '~> 2.0.2'
end
