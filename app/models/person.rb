module Person

  def display_name
    admin_name = ''
    admin_name << self.first_name + ' ' if self.first_name
    admin_name << self.last_name  if self.last_name
    if admin_name == ''
      self.email
    else
      admin_name
    end
  end

end