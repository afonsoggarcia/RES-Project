class ArticlePolicy < ApplicationPolicy

  def show?
    record.accepted ? true : user.admin || record.user == user
  end

  def create?
    user.publisher || user.admin
  end

  def update?
    record.user == user || user.admin
  end

  def destroy?
    user.admin
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
  end
end
