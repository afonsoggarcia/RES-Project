class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show destroy edit update]
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

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    authorize @article
    if @article.save
      redirect_to article_path(@article), notice: "Article successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :subtitle, :content, :photo)
  end
end
