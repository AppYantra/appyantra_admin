class ActivityFeed < ActiveRecord::Base

  scope :latest, order("created_at DESC").limit(10)

end