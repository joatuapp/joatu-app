class OfferPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  def destroy?
    user.is_admin? || scope.user_id == user.id
  end
end
