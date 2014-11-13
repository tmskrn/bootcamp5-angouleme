require 'test_helper'
require 'capybara/rails'

class SearchTest < ActionDispatch::IntegrationTest
  test "data stays in submitted form" do
    visit '/parkings'
    check("private_parking")
    fill_in("city_parkings", with: "Kraków")
    click_button('Search')

    assert has_content? "Parkings"
    assert has_content? "Search parkings"
    assert_equal "Kraków", find_field(:city_parkings).value 
    assert page.has_checked_field?(:private_parking)
  end

  test "search form finds private parkings" do
    visit '/parkings'
    check("private_parking")
    click_button('Search')
    assert page.has_content? "Wroclaw"
    assert page.has_content? "Kind: private"
  end

  test "search form finds public parking in given city" do
    visit '/parkings'
    check("public_parking")
    fill_in("city_parkings", with: "Sulkowice")
    click_button('Search')
    assert page.has_content? "Sulkowice"
    assert_not page.has_content? "Wroclaw"
  end

  test "search form finds parkings with given day price" do
    visit '/parkings'
    fill_in("day_price_from", with: 19)
    fill_in("day_price_to", with: 21)
    click_button('Search')
    assert page.has_content? "Sulkowice"
    assert_not page.has_content? "Wroclaw"
  end

  test "search form finds fitting all criteria" do
    visit '/parkings'
    check("public_parking")
    fill_in("day_price_from", with: 19)
    fill_in("day_price_to", with: 21)
    fill_in("hour_price_from", with: 3)
    fill_in("hour_price_to", with: 8)
    fill_in("city_parkings", with: "Sulkowice")
    click_button('Search')

    assert page.has_content? "Sulkowice"
    assert_not page.has_content? "Wroclaw"
  end
end
