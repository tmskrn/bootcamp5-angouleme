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
end
