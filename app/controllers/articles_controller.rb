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
    @category = Category.find(article_params[:category])
    @article = Article.new(title: article_params[:title], subtitle: article_params[:subtitle], content: article_params[:content], photo: article_params[:photo])
    @article.category = @category
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
    params.require(:article).permit(:title, :subtitle, :content, :category, :photo)
  end
end
