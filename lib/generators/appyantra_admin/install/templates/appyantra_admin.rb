require 'appyantra_admin/utils'
# Use this hook to configure AppYantra Admin
AppyantraAdmin.setup do |config|

  include AppyantraAdmin::Utils

  # specify the model names that can be managed as assets from the Admin dashboard
  # e.g. config.assets = ['Product']
  config.assets = []
  # This phrase is used by the AppyantraAdmin::Crypto library for the AES-256 key
  AppyantraAdmin::Crypto.key_phrase = 'Dont forget to seal all the doors with salt!'


  # By default layouts list is made from haml/erb files in views/layouts
  # You can over-ride this by specifying your list
  # e.g. config.page_layouts ['layout1', 'layout2', 'nested_folder/layout3']
  config.page_layouts = list_page_layouts

  Devise.setup do |config|
    # ==> Mailer Configuration
    # Configure the e-mail address which will be shown in Devise::Mailer,
    # note that it will be overwritten if you use your own mailer class with default "from" parameter.
    config.mailer_sender = "admin.email@yourdomain.com"
  end

  # set the html format used for HTML 5 use :html5
  Haml::Template.options[:format] = :xhtml
end