class UserPolicy < ApplicationPolicy
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

  def index?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    owner_or_admin?
  end

  def destroy?
    owner_or_admin?
  end

  protected

  def owner_or_admin?
    user.is_admin? || (user.id && user.id == record.id)
  end
end
