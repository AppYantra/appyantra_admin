RSpec::Matchers.define :be_displayed_on_show_page do |expected_user|
  match do |description|
    user = User.find_by_email(expected_user.email)
    user.should be
    visit appyantra_admin_user_path(user)

    within "#tab1.tab_content.show_section" do
      page.should have_content(expected_user.first_name)
      page.should have_content(expected_user.last_name)
      page.should have_content(expected_user.email)
    end
  end
end