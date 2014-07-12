class UserSessionRepresenter < UserWithDetailRepresenter
  property :authentication_token
  property :active_for_authentication, exec_context: :decorator

  def active_for_authentication
    represented.active_for_authentication?
  end
end
