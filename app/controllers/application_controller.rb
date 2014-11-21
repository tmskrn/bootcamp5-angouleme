class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_person, :user_logged_in?

  private
  def current_person
   Account.find(session[:current_user_id]).person unless session[:current_user_id].blank?
  end

  def authenticate
    redirect_to new_session_path, alert: "You must be logged in to see this page." if session[:current_user_id].blank?
  end

  def user_logged_in?
    !!session[:current_user_id].present?
  end
end
