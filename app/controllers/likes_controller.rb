class LikesController < ApplicationController
  before_action :find_article
  before_action :find_like, only: [:destroy]

  def create
    skip_authorization
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @article.likes.create(user_id: current_user.id)
    end
    redirect_to article_path(@article)
  end

  def destroy
    skip_authorization
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
    redirect_to article_path(@article)
  end

  def find_like
    @like = @article.likes.find(params[:id])
  end

  private

  def find_article
    @article = Article.find(params[:article_id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, article_id:
    params[:article_id]).exists?
  end

end
