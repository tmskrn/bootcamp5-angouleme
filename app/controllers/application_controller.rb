class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_person, :user_logged_in?, :store_location

  private
  def current_person
   @current_person ||= Account.find(session[:current_account_id]).person if user_logged_in?
  end

  def authenticate
    unless user_logged_in?
      store_location
      redirect_to new_session_path, alert: "You must be logged in to see this page."
    end
  end

  def user_logged_in?
    !!session[:current_account_id].present?
  end

  def store_location
    session[:return_to] = request.fullpath if request.get? 
  end
end
