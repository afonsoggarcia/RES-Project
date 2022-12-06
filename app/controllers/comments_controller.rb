class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home index show destroy update]
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

  def edit
    skip_authorization
    @comment = Comment.find(params[:id])
  end

  def update
    skip_authorization
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @comment, notice: "comment successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    skip_authorization
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to reply_path(@comment.reply), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
