class SearchController < ApplicationController
  before_action :current_user
  
  def index
  end

  def search
    result = search_service.filter
    return render_error(result[:error_code], result[:error_message]) if result[:error_code]

    render json: result[:data], status: :ok
  end

  private

  def search_service
    @search_service ||= SearchService.new(permitted_params, @current_user)
  end

  def permitted_params
    params.permit(:search, :user_id, activity: [])
  end
end