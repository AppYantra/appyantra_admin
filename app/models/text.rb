class Text < ActiveRecord::Base
  def entity_value
    self.value
  end
end
