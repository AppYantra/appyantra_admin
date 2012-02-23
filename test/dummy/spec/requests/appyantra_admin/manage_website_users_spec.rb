require 'spec_helper'
require 'support/matchers/user_matcher'

describe "Admin manages website users" do

  context "when no users are present" do

    login_admin

    it "should show no users present message" do

      within "li.icn_view_users" do
        click_link 'Manage Website Users'
      end

      within "div.tab_content" do
        page.should have_content('No users found.')
      end

    end
  end

  context "when users are created" do

    let!(:user1) { Factory.create(:user) }
    let!(:user2) { Factory.create(:user) }
    let!(:user3) { Factory.create(:user) }

    login_admin

    it "should show a list of users" do

      visit appyantra_admin_users_path

      within "article.module header h3" do
        page.should have_content("Website Users")
      end

      within "div.tab_content" do
        page.should have_content(user1.first_name)
        page.should have_content(user1.last_name)
        page.should have_content(user2.first_name)
        page.should have_content(user2.last_name)
        page.should have_content(user3.first_name)
        page.should have_content(user3.last_name)
      end
    end
  end

  context "when an admin is logged in" do

    login_admin

    let(:user1) { Factory.build(:user) }

    it "he can create a user" do
      visit appyantra_admin_users_path
      within "div.new_button_frame" do
        click_button 'Create New'
      end

      within ".mini_form_box" do
        fill_in 'First name', with: user1.first_name
        fill_in 'Last name', with: user1.last_name
        fill_in 'Email', with: user1.email
        click_button "Create"
      end

      within "section#main.column" do
        page.should have_content("User Profile was successfully created")
      end

      "updated user".should be_displayed_on_show_page(user1)
    end

    let!(:user2) { Factory.create(:user) }
    let!(:updated_user) { Factory.build(:user, first_name: 'Trey', last_name: 'Parker', email: 'trey@appyantra.com') }

    it "he can edit a user" do
      visit edit_appyantra_admin_user_path(user2)

      within ".mini_form_box" do
        fill_in 'First name', with: updated_user.first_name
        fill_in 'Last name', with: updated_user.last_name
        fill_in 'Email', with: updated_user.email
        click_button "Update"
      end

      within "section#main.column" do
        page.should have_content("User Profile was successfully updated")
      end

      "updated user".should be_displayed_on_show_page(updated_user)

    end
  end
end