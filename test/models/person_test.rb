require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test "should not save person without first name" do
    person = Person.new(last_name: "nowak")
    assert person.invalid?
    assert_not person.errors[:first_name].empty? 
  end
end
