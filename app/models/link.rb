class Link < ActiveRecord::Base
  def entity_value
    self.href
  end
end
