class UserRepresenter < ApplicationRepresenter
  property :id, writeable: false
  property :username
  property :email
end
