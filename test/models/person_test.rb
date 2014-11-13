require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test "should not save person without first name" do
    person = Person.new(last_name: "asdf")
    assert person.invalid?
    assert_not person.errors[:first_name].empty? 
  end

  test "should return person's  full name" do
    person = Person.new(first_name: "Jimmy", last_name: "Kimmel")
    assert_equal "Jimmy Kimmel", person.full_name

    person2 = Person.new(first_name: "Bobby")
    assert_equal "Bobby", person2.full_name
  end
end
