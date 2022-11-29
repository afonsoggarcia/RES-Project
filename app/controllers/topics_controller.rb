class TopicsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home index show]
  def index
    skip_policy_scope
    @topics = Topic.all
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

  private

  def topic_params
    params.require(:topic).permit(:title, :description)
  end
end
