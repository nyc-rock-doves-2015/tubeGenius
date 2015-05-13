class SearchController < ApplicationController

  def new
    @search = params[:search]
    @video_results = search_videos(@search)
    @user_results = search_users(@search)
    @comment_results = search_comments(@search)
  end

  def search_videos(search)
    if search 
      Video.where('LOWER(title) LIKE?', "%#{search.downcase}%")
    end
  end

  def search_users(search)
    if search
      User.where('LOWER(name) LIKE ?', "%#{search.downcase}%")
    end
  end

  def search_comments(search)
    if search
      Comment.where('LOWER(content) LIKE ?', "%#{search.downcase}%")
    end
  end

end