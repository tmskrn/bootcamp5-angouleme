class CarsController < ApplicationController
 #before_filter :check_owner, only: [:edit, :update, :show]

 def index
  @cars = current_person.cars 
 end

 def show 
  @car = Car.find(params[:id])
  is_owner?(@car)
 end

 def new 
  @car = Car.new()
 end

 def create
  @car = Car.new(car_params)
  @car.owner = current_person
  if @car.save
   redirect_to car_path(@car)
  else
   render 'new'
  end
 end
 
 def edit
  @car = Car.find(params[:id])
  is_owner?(@car)
 end

 def update
  @car = Car.find(params[:id])
  is_owner?(@car) 
  if @car.update(car_params)
   redirect_to car_path(@car)
  else
   render 'edit'
  end
 end

 def delete
  @car = Car.find(params[:id])
  is_owner?(@car)
  @car.destroy
  redirect_to cars_url
 end

 private
 
 def car_params
  params.require(:car).permit(:model, :registration_number, :owner_id)
 end

 def is_owner?(car)
  redirect_to cars_path, notice: "u don't have permission to do that!" unless @car.owner_id == current_person.id
 end

end
