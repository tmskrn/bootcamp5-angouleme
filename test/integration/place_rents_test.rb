require 'test_helper'
require 'capybara/rails'

class PlaceRentsTest < ActionDispatch::IntegrationTest
 test "user creates new place rent" do
  visit parkings_path
  click_link 'rent place', href: new_parking_place_rent_path(Parking.first)
  #save_and_open_page

  assert_equal current_url, new_parking_place_rent_url(Parking.first)
  select("yaris", from: "place_rent_car_id")
  click_button('go')
  #save_and_open_page
  assert_equal current_url, place_rent_url(PlaceRent.last)
  assert has_content? "You've rented the place"
  assert has_content? "Car: model - yaris"
 end
end