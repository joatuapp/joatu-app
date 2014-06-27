class UserRepresenter < ApplicationRepresenter
  property :id, writeable: false
  property :username
  property :email
  property :detail, extend: UserDetailRepresenter, class: UserDetail, if: lambda{ |opts| opts[:expand_detail] }
end
