require 'test_helper'
require 'capybara/rails'

class PlaceRentsTest < ActionDispatch::IntegrationTest
  def setup
    visit '/session/new'
    fill_in("email", with: "mmgumularz@gmail.com")
    fill_in("password", with: "abc123")
    click_button('Sign in')
  end

  test "user creates new place rent" do
    visit parkings_path
    click_link 'rent place', href: new_parking_place_rent_path(Parking.first)
    assert_equal current_url, new_parking_place_rent_url(Parking.first)
    select("yaris", from: "place_rent_car_id")
    click_button('go')
    assert_equal current_url, show_place_rent_url(PlaceRent.last.identifier)
    assert has_content? "You've rented the place"
    assert has_content? "Car: model - yaris"
  end
end
