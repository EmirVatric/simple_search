class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def search
    results = Article.search(search_params[:search]).limit(6)
    errors = []
    errors << "Sorry, we found 0 results for '#{search_params[:search]}'" if results.empty?
    
    render json: {data: results, errors: errors}, status: 200
  end

  private
  def search_params
    params.permit(:search)
  end
end