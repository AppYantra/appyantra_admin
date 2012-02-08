require 'devise'
require 'formtastic'
require "appyantra_admin/engine" if defined?(Rails)

module AppyantraAdmin
  # model names that can be managed as assets from the Admin dashboard.
  mattr_accessor :assets
  @@assets = []

  # setup for AppYantra Admin to be used in the initializer
  def self.setup
    yield self
  end
end
