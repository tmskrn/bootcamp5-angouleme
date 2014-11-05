class PlaceRent < ActiveRecord::Base
  belongs_to :car
  belongs_to :parking

  validates_presence_of :start_date, :end_date, :parking, :car
end
