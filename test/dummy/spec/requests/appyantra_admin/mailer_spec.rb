require 'spec_helper'

describe "Admin user manages mailer settings" do

  describe "when an admin is logged in" do

    login_admin

    describe "admin creates mail settings" do

      # mail settings
      let(:default_url_host) {'localhost:3000'}
      let(:delivery_method) {'smtp'}
      let(:address) {'smtp.gmail.com'}
      let(:port) {'587'}
      let(:domain) {'localhost'}
      let(:user_name) {'speedy'}
      let(:password) {'speedy123'}
      let(:authentication) {'plain'}
      let(:enable_starttls_auto) {'true'}

      it "is displayed on the settings page" do
        visit settings_path
        within "div#mail_settings" do
          click_link 'Create Mail Settings'
        end

        within ".module" do
          fill_in 'Default url host', with: default_url_host
          fill_in 'Delivery method', with: delivery_method
          fill_in 'Address', with: address
          fill_in 'Port', with: port
          fill_in 'Domain', with: domain
          fill_in 'User name', with: user_name
          fill_in 'Password', with: password
          fill_in 'Authentication', with: authentication
          fill_in 'Enable starttls auto', with: enable_starttls_auto
          click_button "Update"
        end

        within "div#mail_settings" do
          page.should have_content(default_url_host)
          page.should have_content(delivery_method)
          page.should have_content(address)
          page.should have_content(port)
          page.should have_content(domain)
          page.should have_content(user_name)
          page.should have_content(password)
          page.should have_content(authentication)
          page.should have_content(enable_starttls_auto)
        end

      end
    end
  end

end