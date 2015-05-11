class SearchController < ApplicationController

  def new
    @search = params[:search]
    @results = search(@search)
  end

  def search(search)
    if search
      Video.where('LOWER(title) LIKE?', "%#{search.downcase}%") + User.where('LOWER(name) LIKE ?', "%#{search.downcase}%") + Comment.where('LOWER(content) LIKE ?', "%#{search.downcase}%")
    else
      render 'search/noresults'
    end
  end

end