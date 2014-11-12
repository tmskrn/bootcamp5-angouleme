require 'test_helper'

class ParkingTest < ActiveSupport::TestCase
 test "should not save parking without places"  do 
  parking = Parking.new(hour_price: 23.44, day_price: 100.45, kind: "street")
  assert parking.invalid?
  assert_not parking.errors[:places].empty?
 end 

 test "should not save parking without hour_price"  do
  parking = Parking.new(places: 500, day_price: 100.45, kind: "street")
  assert parking.invalid?
  assert_not parking.errors[:hour_price].empty?
 end 

 test "should not save parking without day_price"  do
  parking = Parking.new(places: 500, hour_price: 100.45, kind: "street")
  assert parking.invalid?
  assert_not parking.errors[:day_price].empty?
 end 

 test "should not save parking with kind that's not on given list"  do
  parking = Parking.new(places: 500, hour_price: 23.44, day_price: 100.45, kind: "manamana")
  assert parking.invalid?
  assert_not parking.errors[:kind].empty?
 end 

 test "should save parking with kind that's on given list" do 
  ['indoor', 'outdoor', 'private', 'street'].each do |kind|
   parking = Parking.new(places: 500, hour_price: 23.44, day_price: 100.45, kind: kind)
   assert parking.valid?
   assert parking.errors[:kind].empty? 
  end
 end
 
 test "should not save parking if day price is not a number" do 
  parking = Parking.new(places: 500, hour_price: 100.45, day_price: "asadgergegver" , kind: "street")
  assert parking.invalid?
  assert_not parking.errors[:day_price].empty?
 end

 test "should save parking if day price is numeric" do
  parking = Parking.new(places: 500, hour_price: 15.65, day_price: 345.56 , kind: "street")
  assert parking.valid?
  assert parking.errors[:day_price].empty?
 end 

 test "should not save parking if hour price is not a number" do
  parking = Parking.new(places: 500, hour_price: {}, day_price: 345.56 , kind: "street")
  assert parking.invalid?
  assert_not parking.errors[:hour_price].empty?
 end

 test "should save parking if hour price is numeric" do
  parking = Parking.new(places: 500, hour_price: 15.65, day_price: 345.56 , kind: "street")
  assert parking.valid?
  assert parking.errors[:hour_price].empty? 
 end

 test "should close all place rents when parking is destroyed" do
   p = parkings(:wroclaw)
   p.destroy
   assert_equal Time.now.to_date, place_rents(:two).end_date.to_date
   assert_equal Time.now.to_date, place_rents(:three).end_date.to_date
 end

 test "should scope private parkings" do
   #test in progress
   #assert_equal parkings(:wroclaw), Parking.private_parkings
 end

end
