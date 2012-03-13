module AppyantraAdmin::PagesHelper
  def categories
    Page.where('category is not null').select('distinct category')
  end

  def default_category
    page = Page.where('category is not null').select('distinct category').first
    if page
      page.category
    else
      ''
    end
  end

  def published_status page
    if page.published
      'Yes'
    else
      'No'
    end
  end

  def page_category page
    unless page.category.empty?
      page.category
    else
      'Not specified.'
    end
  end

  def page_keywords(page)
    (page.keywords.collect{|pk| pk.keyword}).join(', ')
  end

  def page_layouts
    ['None'] + AppyantraAdmin.page_layouts
  end
end
