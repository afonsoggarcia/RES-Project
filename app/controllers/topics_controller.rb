class TopicsController < ApplicationController
  before_action :set_topic, only: %i[show destroy edit update]
  skip_before_action :authenticate_user!, only: %i[home index show]
  def index
    skip_policy_scope
    @topics = Topic.all.order("created_at DESC")
    @topic = Topic.new
  end

  def show
    skip_authorization
    @topic = Topic.find(params[:id])
    @reply = Reply.new
    @comment = Comment.new
  end

  def new
    @topic = Topic.new
    @topic.user = current_user
    authorize @topic
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    authorize @topic
    if @topic.save
      redirect_to topic_path(@topic), notice: "Topic created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic
  end

  def destroy
    @topic = Topic.find(params[:id])
    authorize @topic
    @topic.destroy
    redirect_to topics_url, notice: "Topic successfully destroyed."
  end

  def update
    @topic = Topic.find(params[:id])
    authorize @topic
    if @topic.update(topic_params)
      redirect_to @topic, notice: "Topic successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title, :description)
  end
end
