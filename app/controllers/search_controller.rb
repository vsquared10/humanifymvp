class SearchController < ApplicationController
  def search
    if params[:q].nil?
      @results = []
    else
      #@results = Article.search params[:q]
    end
  end
end
