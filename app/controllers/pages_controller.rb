class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about features]

  def home
  end

  def about
  end

  def features
  end
end
