class SessionsController < ApplicationController
  def new
  end

  def create
    session[:current_account_id] = Account.find_by_email(params[:email]).id
    redirect_to root_url
  end

  def destroy
    session.destroy
    redirect_to root_url, notice: 'You have logged out.'
  end
end
