class PlaceRentsController < ApplicationController
  before_filter :authenticate
  
  def index
    @rents = PlaceRent.all
  end

  def show
    @rent = PlaceRent.find_by_identifier(params[:identifier])
  end

  def new
    @place_rent = PlaceRent.new
    @place_rent.parking = Parking.find(params[:parking_id])
  end

  def create
    @place_rent = PlaceRent.new(place_rent_params)

    if @place_rent.save
      redirect_to show_place_rent_path(@place_rent.identifier), notice: "You've rented the place." 
    else
      redirect_to parkings , alert: "Sorry, something went wrong, please try again."
    end 
  end

  private

  def place_rent_params
    params.require(:place_rent).permit(:start_date, :end_date, :car_id, :parking_id)
  end
end
