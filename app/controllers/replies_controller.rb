class RepliesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home index show destroy]
  def index
    skip_policy_scope
    @replies = Reply.all.order("created_at DESC")
  end

  def show
    skip_authorization
  end

  def new
    skip_authorization
    @topic = Topic.find(params[:topic_id])
    @reply = Reply.new
  end

  def create
    skip_authorization
    topic = Topic.find(params[:topic_id])
    @reply = Reply.create(reply_params)
    @reply.topic = topic
    @reply.user = current_user
    if @reply.save
      redirect_to topic_path(topic), notice: 'reply was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    skip_authorization
    @reply = Reply.find(params[:id])
    @reply.destroy
    redirect_to topic_path(@reply.topic), status: :see_other
  end

  private

  def reply_params
    params.require(:reply).permit(:content)
  end
end
