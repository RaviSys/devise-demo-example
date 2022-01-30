class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable, 
         :rememberable, 
         :validatable, 
         :confirmable, 
         :trackable,
         authentication_keys: [:login]

  validates :username, presence: true, uniqueness: true

  attr_accessor :login

  def login
    @login || self.username || self.email
  end

  private

  def after_confirmation
    WelcomeMailer.send_greetings_notification(self)
                 .deliver_now
  end

  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup
    if(login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
