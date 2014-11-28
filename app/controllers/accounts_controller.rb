class AccountsController < ApplicationController
  before_filter :check_guest 

  def new
    @person_account = Person.new
    @person_account.build_account
  end

  def create
    @person_account = Person.new(person_account_params)
    
    if @person_account.save
      redirect_to root_url, notice: "Your account has been created. Enjoy."
    else
      flash.now[:alert] = "Something went wrong, please try again."
      render 'new'
    end
  end

  private

  def person_account_params
    params.require(:person).permit(:first_name, :last_name, account_attributes: [:email, :password, :password_confirmation])
  end

  def check_guest
    redirect_to root_url, notice: "You already have an account" if user_logged_in?
  end
end
