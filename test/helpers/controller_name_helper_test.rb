require 'test_helper'

class ControllerNameHelperTest < ActionView::TestCase
 test 'should return ble ble' do
  assert_equal "Application", current_controller_name(ApplicationController.new())
  assert_not_equal "Test", current_controller_name(ParkingsController.new())
 end
end
