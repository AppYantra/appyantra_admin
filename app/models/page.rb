class Page < ActiveRecord::Base
  belongs_to :last_updated_by, class_name: 'Admin', foreign_key: 'last_updated_by_id'
  belongs_to :created_by, class_name: 'Admin', foreign_key: 'created_by_id'

  validates_uniqueness_of :slug

  def create_slug
    # return if either
    # 1) title is nil or empty
    # 2) slug is already set and slug is not an empty string
    return if (!self.title || (self.slug && self.slug != ''))
    # generate a slug
    slug = self.title.parameterize
    if Page.where(slug: slug).exists?
      slug << '_' + self.id.to_s
    end
    self.slug = slug
    self.save
  end
end