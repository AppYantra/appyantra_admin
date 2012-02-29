module AppyantraAdmin
  class PagesController < ApplicationController

    before_filter(except: [:display]) { |c| c.authenticate_admin! }

    # breadcrumbs
    before_filter(only: [:index, :new, :edit, :show]) { |c| c.add_breadcrumb(['Home', main_app.appyantra_admin_home_path])}
    before_filter(only: [:new, :edit, :show]) { |c| c.add_breadcrumb(['Pages', main_app.appyantra_admin_pages_path])}

    def index
      @page_title = 'Pages'
      current_breadcrumb @page_title
      @pages = Page.all
    end

    def new
      @page_title = 'New Page'
      current_breadcrumb 'New'
      @page = Page.new
    end

    def create
      page = Page.new(params[:page])
      page.last_updated_by = current_admin
      page.created_by = current_admin
      respond_to do |format|
        if page.save
          page.create_slug
          format.html do |format|
            flash[:notice] = "Website Page was successfully created"
            redirect_to main_app.appyantra_admin_pages_path
          end
        else
          # TODO handle errors
        end
      end
    end

    def show
      @page = Page.find(params[:id])
      @page_title = 'Page | ' + @page.title
      current_breadcrumb @page.title
      respond_to do |format|
        format.html
      end
    end

    def edit
      @page = Page.find(params[:id])
      @page_title = 'Pages | ' + @page.title
      add_breadcrumb([@page.title, main_app.appyantra_admin_page_path(@page)])
      current_breadcrumb 'Edit'
      render 'edit'
    end

    def update
      page = Page.find(params[:id])
      page.last_updated_by = current_admin
      respond_to do |format|
        if page.update_attributes(params[:page])
          page.create_slug
          format.html do |format|
            flash[:notice] = "Website Page was successfully updated"
            redirect_to main_app.appyantra_admin_page_path
          end
        else
          # TODO handle errors
        end
      end
    end

    def destroy
      page = Page.find(params[:id])
      page.destroy
      flash[:notice] = "Page was successfully deleted."
      redirect_to main_app.appyantra_admin_pages_path
    end

    def display
      page = Page.find_by_slug(params[:slug])
      if page.published
        @page_title = page.title
        @page_content = page.content
      else
        # TODO redirect to 404 page
        @page_title = 'Page not found'
        @page_content = @page_title
      end
      render '/pages/page', layout: 'application'
    end

  end
end
