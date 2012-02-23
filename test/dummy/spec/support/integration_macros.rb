module IntegrationMacros
  def login_admin
    before(:each) do
      visit new_admin_session_path

      if current_path == new_admin_session_path.to_s
        within(".mini_form_box") do
          password = 'admin123'
          admin_user = Admin.create(email: "admin#{Time.now.to_f}@appyantra.com", password: password, password_confirmation: password)
          fill_in 'Email', with: admin_user.email
          fill_in 'Password', with: password
          click_button "Sign in"
        end
      end
    end
  end

  def login_user
    before(:each) do
      # create a user
      password = 'user123'
      user = User.create(email: "user#{Time.now.to_f}@appyantra.com", password: password, password_confirmation: password)
      # confirm the user
      user.confirm!

      visit root_path

      within "div.login_box" do
        click_link 'Sign in'
      end

      within "div.form_box" do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: password
        click_button 'Sign in'
      end
    end
  end
end