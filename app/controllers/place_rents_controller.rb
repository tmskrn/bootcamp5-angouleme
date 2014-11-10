class PlaceRentsController < ApplicationController
  def index
    @rents = PlaceRent.all
  end

  def show
    @rent = PlaceRent.find(params[:id])
  end

  def new
    @place_rent = PlaceRent.new
    @place_rent.parking = Parking.find(params[:parking_id])
    @cars = current_person.cars
  end

  def create
    @place_rent = PlaceRent.new(place_rent_params)

    if @place_rent.save
      redirect_to @place_rent, notice: "You've rented the place." 
    else
      redirect_to parkings , alert: "Sorry, something went wrong, please try again."
    end 
  end

  private

  def place_rent_params
    params.require(:place_rent).permit(:start_date, :end_date, :car_id, :parking_id)
  end
end
