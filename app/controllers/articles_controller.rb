class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home index show]
  def index
    skip_policy_scope
  end

  def show
    skip_authorization
  end

  def new
    @article = Article.new
    @article.user = current_user
    authorize @article
  end

  def article_params
    params.require(:article).permit(:title, :subtitle, :content, :photo)
  end
end
