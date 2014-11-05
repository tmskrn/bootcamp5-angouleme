class Parking < ActiveRecord::Base
 belongs_to :address
 belongs_to :owner, class_name: "Person"
 has_many :cars
 has_many :place_rents

 validates_presence_of :places, :hour_price, :day_price
 validates :kind, inclusion: {in: w%(outdoor indoor private or street)}
 validates :hour_price, :day_price, numericality: true

end
