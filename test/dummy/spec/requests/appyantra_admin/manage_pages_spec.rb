require 'spec_helper'
require 'fileutils'

describe "Admin manages website pages" do

  before :all do
    # clears the cached pages if generated during dev runs
    FileUtils.rm_rf Rails.root.join("public/pages")
  end

  context "when no pages are present" do

    login_admin

    it "should show no pages present message" do

      within "li.icn_pages" do
        click_link 'Manage Website Pages'
      end

      within "div.tab_content" do
        page.should have_content('No pages found.')
      end

    end
  end

  describe "when pages are created" do

    let!(:page1) { FactoryGirl.create(:page) }
    let!(:page2) { FactoryGirl.create(:page) }
    let!(:page3) { FactoryGirl.create(:page) }

    login_admin

    it "should show a list of pages" do

      visit appyantra_admin_pages_path

      within "article.module header h3" do
        page.should have_content("Website Pages")
      end

      within "div.tab_content" do
        page.should have_content(page1.title)
        page.should have_content(page2.title)
        page.should have_content(page3.title)
      end
    end
  end

  describe "when an admin is logged in" do

    login_admin

    describe "when admin creates and publishes a page" do

      let!(:title) { 'About' }
      let!(:category) { 'static' }
      let!(:content) { 'This is an About page' }
      let!(:description) { 'This is the About page description' }
      let!(:layout) { "application" }

      it "is created and can be accessed" do
        visit appyantra_admin_pages_path
        within "div.new_button_frame" do
          click_button 'Create New'
        end

        within ".page_new" do
          fill_in 'Title', with: title
          choose 'Yes'
          fill_in 'page_category_input', with: category
          fill_in 'Content', with: content
          select layout, from: 'Layout'
          fill_in 'Description', with: description
          click_button "Create"
        end

        within "section#main.column" do
          page.should have_content("Website Page was successfully created")
        end

        slug = title.parameterize # assuming that title is unique
        saved_page = Page.find_by_slug(slug)
        saved_page.should be

        visit display_page_path(saved_page.slug)
        page.should have_content(content)
        page.should have_xpath("//head/meta[@name='description'][@content='" + description + "']")
      end
    end

    describe "when admin updates and publishes a page" do

      let!(:title) { 'About' }
      let!(:category) { 'static' }
      let!(:content) { 'This is an About page' }
      let!(:page4) { FactoryGirl.create(:page) }

      it "is updated and can be accessed" do
        visit edit_appyantra_admin_page_path(page4)

        within ".page_edit" do
          fill_in 'Title', with: title
          choose 'Yes'
          fill_in 'page_category_input', with: category
          fill_in 'Content', with: content
          click_button "Update"
        end

        within "section#main.column" do
          page.should have_content("Website Page was successfully updated")
        end

        slug = title.parameterize # assuming that title is unique
        saved_page = Page.find_by_slug(slug)
        saved_page.should be
        visit display_page_path(saved_page.slug)

        page.should have_content(content)
      end
    end

    describe "when admin creates an unpublished page" do
      let!(:title) { 'About' }
      let!(:category) { 'static' }
      let!(:content) { 'This is an About page' }

      it "is created and cannot be accessed" do
        visit appyantra_admin_pages_path
        within "div.new_button_frame" do
          click_button 'Create New'
        end

        within ".page_new" do
          fill_in 'Title', with: title
          choose 'No'
          fill_in 'page_category_input', with: category
          fill_in 'Content', with: content
          click_button "Create"
        end

        within "section#main.column" do
          page.should have_content("Website Page was successfully created")
        end

        slug = title.parameterize # assuming that title is unique
        saved_page = Page.find_by_slug(slug)
        saved_page.should be
        visit display_page_path(saved_page.slug)

        page.should_not have_content(content)
        page.should have_content('Page not found')
      end
    end

    describe "when admin publishes a page" do

      let!(:title) { 'Contact' }
      let!(:page5) { FactoryGirl.create(:page, title: title, published: false, slug: title.parameterize) }

      it "it can be accessed" do
        visit edit_appyantra_admin_page_path(page5)

        within ".page_edit" do
          choose 'Yes'
          click_button "Update"
        end

        within "section#main.column" do
          page.should have_content("Website Page was successfully updated")
        end

        visit display_page_path(page5.slug)

        page.should have_content(page5.content)

      end
    end

    describe "when admin add keywords to a page" do

      let!(:page6) { FactoryGirl.create(:page, slug: 'test_slug') }
      let!(:keywords) { 'keyword1, keyword2' }

      it "it generates a meta tag for keywords" do
        visit edit_appyantra_admin_page_path(page6)

        within ".page_keywords" do
          fill_in 'keywords', with: keywords
          click_button "Update"
        end

        within "section#main.column" do
          page.should have_content("Page keywords were successfully updated")
          page.should have_content(keywords)
        end

        visit display_page_path(page6.slug)

        page.should have_xpath("//head/meta[@name='keywords'][@content='" + keywords + "']")

      end
    end

  end

end