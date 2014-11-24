class CarsController < ApplicationController
  before_filter :authenticate
  rescue_from ActiveRecord::RecordNotFound, with: :cars_redirect

  def index
    @cars = current_person.cars
  end

  def show 
    @car = current_person.cars.find(params[:id])
  end

  def new 
    @car = Car.new
  end

  def create
    @car = current_person.cars.new(car_params)
    if @car.save
      redirect_to @car, notice: "New car was succesfully created."
    else
      render 'new', alert: "Sorry, something went wrong, please try again."
    end
  end
 
  def edit
    @car = current_person.cars.find(params[:id])
  end

  def update
    @car = current_person.cars.find(params[:id])
    if @car.update(car_params)
      redirect_to @car, notice: "Car was succesfully updated."
    else
      render 'edit', alert: "Sorry, something went wrong, please try again."
    end
  end

  def destroy
    @car = current_person.cars.find(params[:id])
    @car.destroy
    redirect_to cars_url, notice: "Car was deleted."
  end

  private

  def cars_redirect
    redirect_to cars_url, alert: "You can't access this car, you're not its owner."
  end
 
  def car_params
    params.require(:car).permit(:model, :registration_number)
  end
end
