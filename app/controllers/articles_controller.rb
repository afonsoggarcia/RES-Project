class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home index show]
  def index
    skip_policy_scope
  end

  def show
    skip_authorization
  end
end
