class Text < ActiveRecord::Base

  def entity_value
    self.value
  end

  def entity_value=(value)
    self.value = value
    self.save
  end
end
