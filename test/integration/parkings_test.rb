require 'test_helper'
require 'capybara/rails'
#require 'spec_helper'
#require 'integration_test_helper'

class ParkingsTest < ActionDispatch::IntegrationTest

  test "user opens parkings index" do
    visit '/parkings'
    assert has_content? 'Parkings'
  end

  test "user opens parking details" do
    parking = Parking.first
    visit parking_path(parking)
    assert has_content? 'Parking details'
    assert has_content? "Places: #{parking.places}"
  end

  test "user successfully adds a new parking" do
    click_link 'create new parking'

    fill_in("Hour price", with: 345.67)
    fill_in("Day price", with: 3456.12)
    fill_in("Places", with: 30)
    select("indoor", from: "Kind")
    fill_in("City", with: "Krakow")
    fill_in("Street", with: "Mogilska")
    fill_in("Zip code", with: "23-231")
    click_button('go!')

    assert_equal current_url, parking_url(Parking.last)
    assert has_content? "Successfully created new parking."
    assert has_content? "Hour price: #{Parking.last.hour_price}"   
  end

  test "user fails to add a new parking" do 
    visit(new_parking_path)
    select("indoor", from: "Kind")
    fill_in("Hour price", with: "345")
    click_button('go!')
  
    assert_equal current_url, parkings_url
    assert has_content? "Sorry, parking can't be saved due to following errors:" 
    assert has_content? "Address zip code can't be blank"
  end

  test "user edits a parking" do
    visit parkings_path
    parking = Parking.last
    click_link 'edit', :href => edit_parking_path(parking)

    assert_equal current_url, edit_parking_url(parking)

    fill_in("Day price", with: 123)
    assert_equal "123", find_field("Day price").value
    click_button('go!')
    
    assert_equal current_url, parking_url(parking)
    assert has_content? "Parking was successfully updated."
    assert has_content? "Day price: 123"
    assert_not has_content? "Day price: #{parking.places}"
  end

  test "user removes a parking" do
    visit parkings_path
    click_link 'delete', :href => parking_path(Parking.last)
 
    assert_equal current_url, parkings_url
    
  end
end
