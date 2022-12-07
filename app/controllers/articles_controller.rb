class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show destroy edit update]
  skip_before_action :authenticate_user!, only: %i[home index show]

  def index
    skip_policy_scope
    @articles = Article.where(accepted: true).order("created_at DESC")
    if params[:query].present?
      @articles = Article.where("title ILIKE ?", "%#{params[:query]}%")
    else
      @articles = Article.all.first(4)
      @articles = Article.all
    end
    respond_to do |format|
      if turbo_frame_request?
        format.html { render partial: 'shared/list', locals: { articles: @articles } }
      else
        format.html
      end
    end
    @believer = params[:believer] == "true" if params[:believer]
  end

  def show
    authorize @article
  end

  def new
    @article = Article.new
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

  def edit
    @categories = Category.all
    authorize @article
  end

  def update
    if params[:accept] == 'true'
      @article.accepted = true
      authorize @article
      @article.save
      @articles = Article.where(accepted: false)
      render partial: 'pages/newarticles'
    else
      @category = Category.find(params[:article][:category])
      @article.category = @category
      @article.accepted = false
      authorize @article
      if @article.update(article_params)
        redirect_to @article, notice: "Article was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :subtitle, :rich_body, :photo)
  end
end
