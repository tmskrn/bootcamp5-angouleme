require 'test_helper'
require 'capybara/rails'
#require 'spec_helper'
#require 'integration_test_helper'

class ParkingsTest < ActionDispatch::IntegrationTest
  test "user opens parkings index" do
    visit '/parkings'
    assert has_content? 'Parkings'
  end
end
