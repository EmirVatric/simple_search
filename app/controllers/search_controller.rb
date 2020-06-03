class SearchController < ApplicationController
  def index
  end

  def search
    results = Article.search(search_params[:search]).limit(6)
    errors = []
    
    Filter.new(search_params, results.empty? ? false : true).check_query
  

    errors << "Sorry, we found 0 results for '#{search_params[:search]}'" if results.empty?
    render json: {data: results, errors: errors}, status: 200
  end

  private
  def search_params
    params.permit(:search, :user_id, :activity => [])
  end
end