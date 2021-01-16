class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.new
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10).preload(:image)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
