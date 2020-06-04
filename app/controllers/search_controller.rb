class SearchController < ApplicationController
  def index
  end

  def search
    result = search_service.filter
    return render_error result[:error_code] if result[:error_code]

    render json: result[:data], status: :ok
  end

  private

  def search_service
    @search_service ||= SearchService.new(permitted_params)
  end

  def permitted_params
    params.permit(:search, :user_id, activity: [])
  end
end