module AppyantraAdmin
  class PagesController < ApplicationController

    before_filter(except: [:display]) { |c| c.authenticate_admin! }

    # breadcrumbs
    before_filter(only: [:index, :new, :edit, :show]) { |c| c.add_breadcrumb(['Home', main_app.appyantra_admin_home_path])}
    before_filter(only: [:new, :edit, :show]) { |c| c.add_breadcrumb(['Pages', main_app.appyantra_admin_pages_path])}

    cache_sweeper AppyantraAdmin::PagesSweeper, only: [:update, :destroy, :update_keywords]
    caches_page :display

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
      page.slug = Page.generate_slug(page.title) if (page.slug == "" || page.slug.nil?)
      respond_to do |format|
        if page.save
          format.html do |format|
            flash[:notice] = "Website Page was successfully created"
            redirect_to main_app.appyantra_admin_page_path(page)
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
      params[:page][:slug] = Page.generate_slug(params[:page][:title]) if (params[:page][:slug] == "" || params[:page][:slug].nil?)
      respond_to do |format|
        if page.update_attributes(params[:page])
          format.html do |format|
            flash[:notice] = "Website Page was successfully updated"
            redirect_to main_app.appyantra_admin_page_path(page)
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
      if page && page.published
        @page = page
        @page_title = page.title
        page_layout = (page.layout == 'None' ? nil : page.layout)
        render '/pages/page', layout: page_layout
      else
        redirect_to main_app.page_not_found_path
      end
    end

    def update_keywords
      page = Page.find(params[:id])
      keywords_str = params[:keywords]
      keywords = keywords_str.split(',')
      # delete existing keywords
      PageKeyword.where(page_id: page.id).delete_all
      unless keywords.empty?
        keywords.each do |keyword|
          page_keyword = PageKeyword.new(keyword: keyword.strip)
          page.keywords << page_keyword
        end
      end
      if page.save
        flash[:notice] = "Page keywords were successfully updated"
        redirect_to main_app.appyantra_admin_page_path(page)
      else
        # TODO handle errors
      end
    end

    def page_not_found
      # TODO redirect to 404 page and better error handing
      @page = Page.new
      @page_title = 'Page not found'
      @page.content = @page_title
      render '/pages/page', layout: 'application'
    end

  end
end
