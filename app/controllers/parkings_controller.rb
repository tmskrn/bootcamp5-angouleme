class ParkingsController < ApplicationController

 def index
  @parkings = Parking.all
 end

 def show
  @parking = Parking.find(params[:id])
 end

 def new
  @parking = Parking.new()
 end
 
 def create
  @parking = Parking.new(parking_params)
  
  if @parking.save
   redirect_to parking_path(@parking)
  else
   render 'new'
  end 
 end

 def edit
  @parking = Parking.find(params[:id]) 
 end

 def update
  @parking = Parking.find(params[:id])
  if @parking.update(parking_params)
   redirect_to parking_path(@parking)
  else
   render 'edit'
  end 
 end

 def destroy
  @parking = Parking.find(params[:id])
  @parking.destroy
  redirect_to parkings_url
 end
 
 private
 def parking_params
  params.require(:parking).permit(:kind, :hour_price, :day_price, :places, :owner_id, :address_id)
 end
end
