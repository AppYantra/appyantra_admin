class User < ActiveRecord::Base

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
        :registerable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  include Person

  def self.find_for_facebook_oauth(auth)
    if user = User.find_by_email(auth["info"]["email"])
      user
    else
      User.new(:email => auth["info"]["email"], :encrypted_password => Devise.friendly_token[0, 20])
    end
  end
end