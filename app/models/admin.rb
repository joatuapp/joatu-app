class Admin < ActiveRecord::Base
  self.table_name = :users
  default_scope { where(is_admin: true) }

  devise :database_authenticatable, 
         :recoverable, :rememberable, :confirmable, 
         :trackable, :validatable

end
