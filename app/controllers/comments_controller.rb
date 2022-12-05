class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home index show destroy]
  def index
    skip_policy_scope
    @comments = Comment.all.order("created_at DESC")
  end

  def show
    skip_authorization
  end

  def new
    skip_authorization
    @topic = Topic.find(params[:topic_id])
    @reply = Reply.find(params[:reply_id])
    @comment = Comment.new
  end

  def create
    skip_authorization
    topic = Topic.find(params[:topic_id])
    reply = Reply.find(params[:reply_id])
    @comment = Comment.create(comment_params)
    @comment.reply = reply
    @comment.user = current_user
    if @comment.save
      redirect_to topic_path(topic)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end