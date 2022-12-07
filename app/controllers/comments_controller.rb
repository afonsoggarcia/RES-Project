class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show destroy edit update]
  skip_before_action :authenticate_user!, only: %i[home index show]

  def index
    skip_policy_scope
    @comments = Comment.all.order("created_at DESC")
  end

  def show
    skip_authorization
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @reply = Reply.find(params[:reply_id])
    @comment = Comment.new(comment_params)
    @comment.reply = @reply
    @comment.user = current_user
    authorize @comment
    if @comment.save
      redirect_to topic_path(@topic)
    else
      redirect_to topic_path(@topic), status: :unprocessable_entity, notice: "comment can't be blank"
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def update
    @comment = Comment.find(params[:id])
    authorize @comment
    if @comment.update(comment_params)
      redirect_to @comment, notice: "comment successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    authorize @comment
    redirect_to reply_path(@comment.reply), status: :see_other
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
