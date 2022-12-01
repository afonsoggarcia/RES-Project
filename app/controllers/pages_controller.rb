class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about features]

  def home
    redirect_to articles_path if user_signed_in?
  end

  def about
  end

  def features
  end

  def dashboard
    current_user.admin ? @articles = Article.where(accepted: false) : @articles = Article.where(user: current_user)
    @articles = policy_scope(Article)

    respond_to do |format|
      if turbo_frame_request? && turbo_frame_request_id == 'content'
        format.html { render partial: params[:query] }
      else
        format.html
      end
      # format.text { render partial: "articles/list", locals: {articles: @articles}, formats: [:html] }
    end
  end

  def content
  end

end
