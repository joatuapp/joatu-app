class Offer::GoodSearchResultRepresenter < Offer::GoodRepresenter
  property :user, extend: UserWithDetailRepresenter, class: UserWithDetail, exec_context: :decorator

  def user
    UserWithDetail.new(user: represented.user, user_detail: represented.user.detail)
  end
end
