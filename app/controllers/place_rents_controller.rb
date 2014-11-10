class PlaceRentsController < ApplicationController
  def index
    @rents = PlaceRent.all
  end

  def show
    @rent = PlaceRent.find(params[:id])
  end

  def new
    @rent = PlaceRent.new
    @rent.parking = Parking.find(params[:parking_id])
    @cars = current_person.cars
  end

  def create
  end

  private

  def place_rent_params
    params.require(:place_rent).permit(:start_date, :end_date, :parking_id, :car_id)
  end
end
