require 'spec_helper'

describe "Admin lands on the Dashboard" do

  login_admin

  describe "when admin is logged in" do

    let!(:user) { FactoryGirl.create(:user) }
    let!(:previous_title) {'previous_title'}
    let!(:page1) { FactoryGirl.create(:page, title: 'test_page1', slug: 'test_page1') }
    let!(:page2) { FactoryGirl.create(:page, title: previous_title, slug: 'test_page2') }
    let!(:updated_title) {'updated_title'}

    it "activity feed is displayed" do
      visit edit_appyantra_admin_page_path(page2)

      within ".page_edit" do
        fill_in 'Title', with: updated_title
        click_button "Update"
      end

      visit appyantra_admin_home_path

      within ".activity_feeds .module_content" do
        page.should have_content("User #{user.display_name} was created")
        page.should have_content("#{page1.created_by.display_name} created Page #{page1.title}")
        page.should have_content("#{page1.created_by.display_name} created Page #{previous_title}")
        page.should have_content("Admin User updated Page #{updated_title}")
      end
    end
  end

end