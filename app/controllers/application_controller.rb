class ApplicationController < ActionController::Base
  protected

  def current_user
    @current_user = 112342
   # @current_user ||= "#{request.remote_ip}".gsub(/[^0-9A-Za-z]/, '').to_i
  end

  def render_error(error)

  end
end
