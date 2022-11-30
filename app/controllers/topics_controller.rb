class TopicsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home index show destroy update]
  def index
    skip_policy_scope
    @topics = Topic.all.order("created_at DESC")
  end

  def show
    skip_authorization
    @topic = Topic.find(params[:id])
  end

  def new
    skip_authorization
    @topic = Topic.new
  end

  def create
    skip_authorization
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    if @topic.save
      redirect_to topic_path(@topic), notice: "Topic created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    skip_authorization
    @topic = Topic.find(params[:id])
  end

  def destroy
    skip_authorization
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_url, notice: "Topic was successfully destroyed."
  end

  def update
    skip_authorization
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
      redirect_to @topic, notice: "topic was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :description)
  end
end
