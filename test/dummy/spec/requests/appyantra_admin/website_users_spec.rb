require 'spec_helper'

describe "Website users use the website" do

  let(:password) { 'user123' }
  let(:user1) { FactoryGirl.create(:user, password: password, password_confirmation: password) }

  login_user

  it "should allow the user to sign in" do
    within ".alert_message" do
      page.should have_content('Signed in successfully.')
    end
  end

  it "should allow the user to sign out" do
    within "div.login_box" do
      click_link 'Sign out'
    end

    within ".alert_message" do
      page.should have_content('Signed out successfully.')
    end
  end
end