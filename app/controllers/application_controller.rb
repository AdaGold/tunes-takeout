class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_user=(user)
    session[:user_id] = user&.id
    @current_user = user
  end

  helper_method :display_name
  def display_name
    current_user&.display_name || t(:guest_name)
  end

  helper_method :signed_in?
  def signed_in?
    !current_user.nil?
  end
end
