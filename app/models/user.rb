class User < UserBase

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, 
         :trackable, :validatable,
         :token_authenticatable,
         :authentication_keys => [:login]

  before_save :ensure_authentication_token

  attr_accessor :login # Holds data that can be used to login.

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup

    if login = conditions.delete(:login)
      where(conditions).where("lower(username) = :value OR lower(email) = :value", value: login.downcase).first
    else
      where(conditions).first
    end
  end
end
