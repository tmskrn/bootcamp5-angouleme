require 'test_helper'

class ControllerNameHelperTest < ActionView::TestCase
 test 'should return name of current controller in human readable form' do
  assert_equal "Test", current_controller_name
  assert_not_equal "Application", current_controller_name
 end
end
