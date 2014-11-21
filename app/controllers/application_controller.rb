class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_person

  private
  def current_person
   Account.find(session[:current_user_id]).person unless session[:current_user_id].blank?
  end
end
