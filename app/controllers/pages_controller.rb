class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about features]

  def home
    redirect_to articles_path if user_signed_in?
  end

  def about
  end

  def features
  end

  def dashboard
  end
end
