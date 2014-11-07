class PlaceRentsController < ApplicationController
  def index
   @rents = PlaceRent.all
  end

  def show
   @rent = PlaceRent.find(params[:id])
  end
end
