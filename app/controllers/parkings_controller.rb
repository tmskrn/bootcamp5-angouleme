class ParkingsController < ApplicationController

  def index
    @parkings = Parking.search(params)
  end

  def show
    @parking = Parking.find(params[:id])
  end

  def new
    @parking = Parking.new
    @parking.build_address
  end
 
  def create
    @parking = Parking.new(parking_params)
  
    if @parking.save
      redirect_to @parking, notice: "Successfully created new parking."
    else
      render 'new'
    end 
  end

  def edit
    @parking = Parking.find(params[:id]) 
    @parking.build_address unless @parking.address.present?
  end

  def update
    @parking = Parking.find(params[:id])
    if @parking.update(parking_params)
      redirect_to @parking, notice: "Parking was successfully updated."
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
    params.require(:parking).permit(:kind, :hour_price, :day_price, :places, 
                                  :address_attributes => [:city, :street, :zip_code])
  end
end
