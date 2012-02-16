class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

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
