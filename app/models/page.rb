class Page < ActiveRecord::Base
  # TODO soft delete feature and userstamp

  belongs_to :last_updated_by, class_name: 'Admin', foreign_key: 'last_updated_by_id'
  belongs_to :created_by, class_name: 'Admin', foreign_key: 'created_by_id'
  has_many :keywords, class_name: 'PageKeyword'

  validates :slug, uniqueness: true
  validates :title, presence: true

  def self.generate_slug title
    # generate a slug
    slug = title.parameterize
    if Page.where(slug: slug).exists?
      slug_count = Page.where(slug: slug).count
      slug << '_' + (slug_count + 1).to_s
    end
    slug
  end

  def identifier
    self.title
  end
end