module AppyantraAdmin
  class AssetsController < ApplicationController
    before_filter :authenticate_admin!
    before_filter :set_asset
    # breadcrumbs
    before_filter(only: [:show, :new, :edit]) { |c| c.add_breadcrumb(['Home', main_app.appyantra_admin_home_path])}
    before_filter(only: [:new, :edit]) { |c| c.add_breadcrumb([@asset_name.pluralize, "/appyantra_admin/assets/#{@asset_name}"])}

    def show
      @page_title = @asset_name.pluralize
      current_breadcrumb @page_title
      @asset_objects = @asset_class.all
      @asset_object = @asset_class.find(params[:id]) if params[:id]
    end

    def new
      @page_title = 'New'
      current_breadcrumb @page_title
      @asset_object = @asset_class.new
    end

    def create
      asset_object_name = get_object_name @asset_class
      @asset_object = @asset_class.new(params[asset_object_name.to_sym])

      respond_to do |format|
        if @asset_object.save
          format.html do |format|
            flash[:notice] = "#{@asset_name} was successfully created."
            redirect_to "/appyantra_admin/assets/#{@asset_name}/#{@asset_object.id}/show"
          end
        else
          # TODO handle errors
          # format.html { render action: "new" }
        end
      end
    end

    def update
      @asset_object = @asset_class.find(params[:id])
      asset_object_name = @asset_class.table_name.singularize
      respond_to do |format|
        if @asset_object.update_attributes(params[asset_object_name.to_sym])
          format.html do |format|
            flash[:notice] = "#{@asset_name} was successfully updated."
            redirect_to "/appyantra_admin/assets/#{@asset_name}/#{@asset_object.id}/show"
          end
        else
          # TODO handle errors
        end
      end
    end

    def destroy
      @asset_object = @asset_class.find(params[:id])
      @asset_object.destroy

      respond_to do |format|
        format.html do |format|
          flash[:notice] = "#{@asset_name} was successfully deleted."
          redirect_to "/appyantra_admin/assets/#{@asset_name}"
        end
      end
    end

    def edit
      asset_id = params[:id]
      @asset_object = @asset_class.find(asset_id)
      add_breadcrumb(["#{asset_display_name @asset_object}", "/appyantra_admin/assets/#{@asset_name}/#{asset_id}/show"])
      @page_title = 'Edit'
      current_breadcrumb @page_title
    end

    def display
      @asset_object = @asset_class.find(params[:id])
      respond_to do |format|
        format.js
      end
    end

    private

    def set_asset
      @asset_name = params[:asset_name]
      raise "Asset #{@asset_name} cannot be managed through Admin" unless AppyantraAdmin.assets.include? @asset_name
      @page_title = "Assets | #{@asset_name}"
      @asset_class = eval @asset_name
    end

  end
end
