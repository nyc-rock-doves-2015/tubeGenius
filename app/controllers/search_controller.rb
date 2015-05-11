class SearchController < ApplicationController

  def new
    @search = params[:search]
    @results = search(@search)
  end

  def search(search)
    if search
      Video.where('title LIKE?', "%#{search}%") + User.where('name LIKE ?', "%#{search}%") + Comment.where('content LIKE ?', "%#{search}%")
    else
      render 'search/noresults'
    end
  end

end