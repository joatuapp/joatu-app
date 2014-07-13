class ImagePolicy < ApplicationPolicy
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

  def show? 
    true
  end

  def create?
    admin_or_owner?
  end

  def update?
    admin_or_owner?
  end

  def destroy?
    admin_or_owner?
  end

  protected

  def admin_or_owner?
    user.is_admin? || (user.id && record.owner_id == user.id)
  end
end
