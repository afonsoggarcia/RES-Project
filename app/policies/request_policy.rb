class RequestPolicy < ApplicationPolicy

  def create?
    true
  end

  def update?
    user.admin
  end

  class Scope < Scope
    # scope.all
  end
end
