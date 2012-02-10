require 'spec_helper'

describe "Admin User Authentication" do
  describe "User lands on the Home page" do
    it "redirects to the login page" do
      get root_path
      response.should redirect_to(new_admin_session_path)
    end

    it "opens the Sign-in page" do
      visit root_path
      within "article.module header h3" do
        page.should have_content("Sign in")
      end
    end
  end
end
