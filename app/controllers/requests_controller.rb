class RequestsController < ApplicationController

  def update
    @request = Request.find(params[:id])
    authorize @request
    @request.accepted = true
    user = @request.user
    user.publisher = true
    user.save
    @request.save
    render partial: 'pages/requests'
  end

  def destroy
    @request = Request.find(params[:id])
    authorize @request
    @request.destroy
    render partial: 'pages/requests'
  end

  def create
    @request = Request.new(request_params)
    @request.user = current_user
    authorize @request
    if @request.save
      redirect_to dashboard_path(query: 'news'), notice: "Your request has been sent to our staff."
    else
      render partial: 'pages/become', status: :unprocessable_entity
    end
  end

  private

  def request_params
    params.require(:request).permit(:content)
  end
end
