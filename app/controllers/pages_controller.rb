class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about features]

  def home
    redirect_to articles_path if user_signed_in?
  end

  def about
    skip_policy_scope
    @publishers = User.where(publisher: true)
  end

  def converted
    convert_user unless current_user.believer
  end

  def features
  end

  def chatrooms
  end

  def dashboard
    current_user.admin ? admin_info : @articles = Article.where(user: current_user)
    @publishers = User.where(publisher: true)

    respond_to do |format|
      if turbo_frame_request? && turbo_frame_request_id == 'content'
        format.html { render partial: params[:query] }
      else
        format.html
      end
      # format.text { render partial: "articles/list", locals: {articles: @articles}, formats: [:html] }
    end
  end

  def calculator
    return unless params[:pointa] && params[:pointb]

    point_a = latlong(params[:pointa])
    point_b = latlong(params[:pointb])
    @great_circle = calculate_gc(point_a, point_b)
    @rhumb_dist = calculate_rhumb(point_a, point_b)
  end

  def convert_user
    user = current_user
    user.converted = true
    user.believer = true
    user.save
  end

  def distance; end

  private

  def admin_info
    @articles = Article.where(accepted: false)
    @topics = Topic.joins(:replies).all.order('replies.created_at DESC').uniq
    @publishers = User.where(publisher: true)
  end

  def latlong(address)
    Geocoder.search(address).first.coordinates
  end

  def calculate_gc(a, b)
    radius = 6371
    d_lat = (b[0] - a[0]) * (Math::PI / 180)
    d_long = (b[1] - a[1]) * (Math::PI / 180)
    first = (Math.sin(d_lat / 2) * Math.sin(d_lat / 2)) +
            Math.cos((a[0]) * (Math::PI / 180)) *
            Math.cos((b[0]) * (Math::PI / 180)) *
            Math.sin(d_long / 2) * Math.sin(d_long / 2)
    second = 2 * Math.atan2(Math.sqrt(first), Math.sqrt(1 - first))
    radius * second # Distance in km
  end

  def calculate_rhumb(point_a, point_b)
    radius = 6371e3; # metres
    lat_a = point_a[0] * Math::PI / 180
    lat_b = point_b[0] * Math::PI / 180
    d_lat = (point_b[0] - point_a[0]) * Math::PI / 180
    d_long = longitude_diff(point_a[1], point_b[1]) * Math::PI / 180
    dep = Math.log(Math.tan(Math::PI / 4 + lat_b / 2) / Math.tan(Math::PI / 4 + lat_a / 2))
    q = dep.abs > 10e-12 ? d_lat/dep : Math.cos(lat_a) # E-W course becomes ill-conditioned with 0/0

    Math.sqrt(d_lat * d_lat + q * q * d_long * d_long) * radius / 1000 # distance in kilometers
  end

  def mean_latitude(lat_a, lat_b)
    sign_check = (lat_a.positive? && lat_b.positive?) || ((lat_a.negative? && lat_b.negative?))
    if sign_check
      lat_a.positive? ? (lat_a + lat_b) / 2 : -(lat_a + lat_b) / 2
    elsif lat_a.positive?
      (lat_a + lat_b) > 0 ? (lat_a + lat_b) / 2 : (lat_b + lat_a) / 2
    else
      (lat_b - lat_a) > 0 ? (lat_b + lat_a) / 2 : (lat_a + lat_b) / 2
    end
  end

  def longitude_diff(long_a, long_b)
    sign_check = (long_a.positive? && long_b.positive?) || (long_a.negative? && long_b.negative?)
    if sign_check
      long_a > long_b ? long_a - long_b : long_b - long_a
    elsif long_a.positive?
      (long_a - long_b) > 180 ? (180 - long_a) + (180 + long_b) : long_a - long_b
    else
      (long_b - long_a) > 180 ? (180 - long_b) + (180 + long_a) : long_b - long_a
    end
  end

end
