class UserRepresenter < ApplicationRepresenter
  property :id, writeable: false
  property :username
  property :email

  property :created_at, writeable: false
  property :updated_at, writeable: false
end
