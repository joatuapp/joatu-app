class Admin < UserBase
  default_scope { where(is_admin: true) }

  devise :database_authenticatable, 
         :recoverable, :rememberable, :confirmable, 
         :trackable, :validatable

end
