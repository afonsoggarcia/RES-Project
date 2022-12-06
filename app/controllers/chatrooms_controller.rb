class ChatroomsController < ApplicationController
  def index
    skip_policy_scope
    @chatrooms = Chatroom.all.order("created_at DESC")
    @chatroom = Chatroom.new
  end

  def show
    skip_authorization
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end
end
