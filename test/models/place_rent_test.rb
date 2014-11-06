require 'test_helper'

class PlaceRentTest < ActiveSupport::TestCase
  test "should not save place rent without start date" do
   place_rent = PlaceRent.new(end_date: Time.now + 3.days, parking: parkings(:wroclaw), car: cars(:porsche))
   assert place_rent.invalid?
   assert_not place_rent.errors[:start_date].empty?
  end

  test "should not save place rent without end date" do
   place_rent = PlaceRent.new(start_date: Time.now, parking: parkings(:wroclaw), car: cars(:porsche))
   assert place_rent.invalid?
   assert_not place_rent.errors[:end_date].empty?
  end

  test "should not save place rent without parking" do
   place_rent = PlaceRent.new(start_date: Time.now, end_date: Time.now + 2.days, car: cars(:porsche))
   assert place_rent.invalid?
   assert_not place_rent.errors[:parking].empty?
  end

  test "should not save place rent without car" do
   place_rent = PlaceRent.new(start_date: Time.now, end_date: Time.now + 2.days,  parking: parkings(:wroclaw))
   assert place_rent.invalid?
   assert_not place_rent.errors[:car].empty?
  end
end
