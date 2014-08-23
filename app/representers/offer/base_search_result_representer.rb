class Offer::BaseSearchResultRepresenter < Offer::BaseRepresenter
  property :user, extend: UserWithDetailRepresenter, class: UserWithDetail, exec_context: :decorator

  def user
    UserWithDetail.new(user: represented.user, user_detail: represented.user.detail)
  end
end
