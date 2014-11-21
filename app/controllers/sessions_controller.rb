class SessionsController < ApplicationController
  def new
  end

  def create
    session[:current_user_id] = Account.find_by_email(params[:email]).id
    redirect_to root_url
  end
end
