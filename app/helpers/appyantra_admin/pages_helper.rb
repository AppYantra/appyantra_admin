module AppyantraAdmin::PagesHelper
  def categories
    Page.where('category is not null').select('distinct category')
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
end
