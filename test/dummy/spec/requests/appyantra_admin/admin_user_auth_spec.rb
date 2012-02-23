require 'spec_helper'

describe "Admin User Authentication" do

  describe "User lands on the Home page" do
    it "redirects to the login page" do
      get appyantra_admin_home_path
      response.should redirect_to(new_admin_session_path)
    end

    it "opens the Sign-in page" do
      visit appyantra_admin_home_path
      within "article.module header h3" do
        page.should have_content("Sign in")
      end
    end
  end

  describe "Admin User logs in" do

    let(:password) { "admin123"}
    let(:admin_user) { Factory.create(:admin, password: password) }

    it "should succeed for the correct username and password" do
      visit new_admin_session_path
      within(".mini_form_box") do
        fill_in 'Email', with: admin_user.email
        fill_in 'Password', with: password
        click_button "Sign in"
      end
      find('header h3').should have_content('Welcome to AppYantra Admin.')
    end

    it "should fail for an incorrect username" do
      visit new_admin_session_path
      within(".mini_form_box") do
        fill_in 'Email', with: 'unknown@appyantra.com'
        fill_in 'Password', with: password
        click_button "Sign in"
      end
      find('.landing_alert h4').should have_content('Invalid email or password.')
    end

    it "should fail for an incorrect password" do
      visit new_admin_session_path
      within(".mini_form_box") do
        fill_in 'Email', with: admin_user.email
        fill_in 'Password', with: password + 'x'
        click_button "Sign in"
      end
      find('.landing_alert h4').should have_content('Invalid email or password.')
    end
  end
end
