require 'devise'
require 'formtastic'
require 'haml'
require 'appyantra_admin/utils'
require 'appyantra_admin/crypto'
require "appyantra_admin/engine" if defined?(Rails)

module AppyantraAdmin
  # model names that can be managed as assets from the Admin dashboard.
  mattr_accessor :assets
  @@assets = []

  # mail setting fields
  mattr_accessor :mail_settings_fields
  @@mail_settings_fields = {}

  # to check if rake is running
  mattr_accessor :rake_running
  @@rake_running = false

  # layouts for pages
  mattr_accessor :page_layouts
  @@page_layouts = nil

  # setup for AppYantra Admin to be used in the initializer
  def self.setup
    yield self
  end

  def self.setup_mailer
    mailer_settings = AdminSetting.group_settings 'Mail'
    password = AppyantraAdmin::Crypto.decrypt(mailer_settings[:password]) if mailer_settings[:password]
    ActionMailer::Base.default_url_options = { :host => 'localhost:3000' }
    unless mailer_settings.empty?
      ActionMailer::Base.default_url_options = { :host => mailer_settings[:default_url_host] }
      ActionMailer::Base.delivery_method = mailer_settings[:delivery_method].to_sym if mailer_settings[:delivery_method]
      ActionMailer::Base.smtp_settings = {
          :address => mailer_settings[:address],
          :port => (mailer_settings[:port] || "587").to_i,
          :domain => mailer_settings[:domain],
          :user_name => mailer_settings[:user_name],
          :password => (password || nil),
          :authentication => mailer_settings[:authentication],
          :enable_starttls_auto => (mailer_settings[:enable_starttls_auto] == "true")
      }
    end
  end
end
