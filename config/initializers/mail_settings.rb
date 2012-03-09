unless AppyantraAdmin.rake_running
  AppyantraAdmin.setup do |config|
    # initialize mailer settings
    config.mail_settings_fields = {'ShortText' => ['default_url_host', 'delivery_method',
                                   'address', 'port', 'domain',
                                   'user_name', 'authentication',
                                   'enable_starttls_auto'],
                                   'EncryptedText' => ['password']}
    AppyantraAdmin.setup_mailer
  end
end
