class DevicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    return true
  end

  def edit?
    owner?
  end

  def update?
    edit?
    # - record: the restaurant passed to the `authorize` method in controller
    # - user:   the `current_user` signed in with Devise.
  end

  def destroy?
    owner?
  end

private

  def owner?
    record.user == user
  end
end
