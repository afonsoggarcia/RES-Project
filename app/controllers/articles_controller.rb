class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home index show]
  def index
  end

  def show
  end
end
