# Use this hook to configure AppYantra Admin
AppyantraAdmin.setup do |config|
  # specify the model names that can be managed as assets from the Admin dashboard
  # e.g. config.assets = ['Product']
  config.assets = []
  # This phrase is used by the AppyantraAdmin::Crypto library for the AES-256 key
  AppyantraAdmin::Crypto.key_phrase = 'Dont forget to seal all the doors with salt!'

  Devise.setup do |config|
    # ==> Mailer Configuration
    # Configure the e-mail address which will be shown in Devise::Mailer,
    # note that it will be overwritten if you use your own mailer class with default "from" parameter.
    config.mailer_sender = "admin.email@yourdomain.com"
  end
end