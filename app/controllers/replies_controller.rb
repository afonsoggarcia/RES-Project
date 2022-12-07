class RepliesController < ApplicationController
  before_action :set_reply, only: %i[show destroy edit update]
  skip_before_action :authenticate_user!, only: %i[home index show]
  def index
    skip_policy_scope
    @replies = Reply.all.order("created_at DESC")
  end

  def show
    skip_authorization
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @reply = Reply.new
    @comment = Comment.new
    authorize @reply
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @reply = Reply.create(reply_params)
    @reply.topic = @topic
    @reply.user = current_user
    authorize @reply
    if @reply.save
      redirect_to topic_path(@topic)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @reply = Reply.find(params[:id])
    authorize @reply
  end

  def update
    @reply = Reply.find(params[:id])
    authorize @reply
    if @reply.update(reply_params)
      redirect_to @reply, notice: "reply successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy
    authorize @reply
    redirect_to topic_path(@reply.topic), status: :see_other
  end

  private

  def set_reply
    @reply = Reply.find(params[:id])
  end

  def reply_params
    params.require(:reply).permit(:content)
  end
end
