class SessionsController < ApplicationController

  def new
  end

  def create
    account = Account.authenticate(params[:email], params[:password])

    if account
      session[:current_account_id] = account.id
      redirect_to session[:return_to]  || root_url, notice: 'You have successfully logged in.'
    else
      flash.now.alert = 'Invalid email or password. Please try again.'
      render 'new'  
    end
  end

  def destroy
    session.destroy
    redirect_to root_url, notice: 'You have logged out.'
  end
  
end
