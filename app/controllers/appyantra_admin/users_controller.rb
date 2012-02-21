module AppyantraAdmin
  class UsersController < ApplicationController

    include AppyantraAdmin::Utils
    
    before_filter :authenticate_admin!
    
    # breadcrumbs
    before_filter(only: [:index, :new, :edit, :show]) { |c| c.add_breadcrumb(['Home', main_app.appyantra_admin_home_path])}
    before_filter(only: [:new, :edit, :show]) { |c| c.add_breadcrumb(['User Profiles', main_app.appyantra_admin_users_path])}
    
    def index
      @page_title = 'User Profiles'
      current_breadcrumb @page_title
    	@users = User.all
    end
    
    def new
      @page_title = 'New User'
      current_breadcrumb 'New'
      @user = User.new
    end
    
    def create
      selected_user = User.new(params[:user])
      password = random_password
      selected_user.password = password
      selected_user.password_confirmation = password
      respond_to do |format|
        if selected_user.save
          format.html do |format|
            flash[:notice] = "User Profile was successfully created"
            redirect_to main_app.appyantra_admin_users_path
          end
        else
          # TODO handle errors
        end
      end  
    end
  
    def show
      @selected_user = User.find(params[:id])
      @page_title = 'User | ' + @selected_user.display_name
      current_breadcrumb @selected_user.display_name
      respond_to do |format|
        format.html
        format.js
      end	
    end
  
    def edit
      @user = User.find(params[:id])
      @page_title = 'User | ' + @user.display_name
      add_breadcrumb([@user.display_name, main_app.edit_appyantra_admin_user_path(@user)])
      current_breadcrumb 'Edit'
      render 'edit'
    end
  
    def update
    	selected_user = User.find(params[:id])
      respond_to do |format|
        if selected_user.update_attributes(params[:user])
          format.html do |format|
            flash[:notice] = "User Profile was successfully updated."
            redirect_to main_app.appyantra_admin_users_path
          end
        else
          # TODO handle errors
        end
      end
    end
    
    def update_password
      user = User.find(params[:id])
      password_params = params[:user]
      user.reset_password!(password_params[:password], password_params[:password_confirmation])
      # TODO Fix auto logout issue when password is changed
      # sign_in(current_admin, :bypass => true)
      flash[:notice] = "Password was successfully updated."
      redirect_to main_app.appyantra_admin_users_path
      # TODO handle errors
    end
    
    def destroy
      user = User.find(params[:id])
      user.destroy
      flash[:notice] = "User was successfully deleted."
      redirect_to main_app.appyantra_admin_users_path
    end
  
  end
end
