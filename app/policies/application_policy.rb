class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  def rails_admin?(action)
    case action
      when :dashboard
        user.is_admin?
      when :index
        user.is_admin?
      when :show
        user.is_admin?
      when :new
        user.is_admin?
      when :edit
        user.is_admin?
      when :destroy
        user.is_admin?
      when :export
        user.is_admin?
      when :history
        user.is_admin?
      when :show_in_app
        user.is_admin?
      else
        raise ::Pundit::NotDefinedError, "unable to find policy #{action} for #{record}."
    end
  end
end

