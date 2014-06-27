class StaticPageController < ApplicationController
  def home
    if sign_in?
      @micropost=current_user.microposts.build
      @feeds=current_user.feed.paginate(:page=>params[:page],:per_page=>21)
    end
  end

  def help
  end

  def about
  end
end
