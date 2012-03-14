module AppyantraAdmin
  class PagesSweeper < ActionController::Caching::Sweeper

    observe Page

    def after_update(page)
      expire_page_for page
    end

    def after_destroy(page)
      expire_page_for page
    end

    private

    def expire_page_for(page)
      expire_page main_app.display_page_path(page.slug) if page && page.slug
    end
  end
end