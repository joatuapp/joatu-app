class UserSessionRepresenter < UserRepresenter
  property :authentication_token
  property :active_for_authentication, decorator_scope: true

  def active_for_authentication
    represented.active_for_authentication?
  end
end
