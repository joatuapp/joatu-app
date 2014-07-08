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

  def create?
    admin_or_owner
  end

  def destroy?
    admin_or_owner
  end

  def admin_or_owner
    user.is_admin? || scope.user_id == user.id
  end
end
