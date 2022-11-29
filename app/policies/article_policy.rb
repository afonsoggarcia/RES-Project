class ArticlePolicy < ApplicationPolicy

  def create?
    record.user.publisher || record.user.admin
  end

  def update?
    record.user.publisher || record.user.admin
  end

  def destroy?
    record.user.admin
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
