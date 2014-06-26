class UserRepresenter < ApplicationRepresenter
  property :id, writeable: false
  property :username
  property :email
  property :detail, extend: UserDetailRepresenter, class: UserDetail
end
