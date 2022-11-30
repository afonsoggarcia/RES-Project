class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show destroy edit update]
  skip_before_action :authenticate_user!, only: %i[home index show]
  def index
    skip_policy_scope
    @articles = Article.all
  end

  def show
    skip_authorization
  end

  def new
    @article = Article.new
    @article.user = current_user
    @categories = Category.all
    authorize @article
  end

  def create
    @category = Category.find(params[:article][:category])
    @article = Article.new(article_params)
    @article.category = @category
    @article.user = current_user
    authorize @article
    if @article.save
      redirect_to article_path(@article), notice: "Article successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def dash_index
    @articles = Article.where(accepted: false)
    @articles = policy_scope(Article)
  end

  def publisher_index
    @articles = Article.where(user: current_user)
    @articles = policy_scope(Article)
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :subtitle, :rich_body, :photo)
  end
end
