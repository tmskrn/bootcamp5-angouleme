require 'test_helper'

class CarTest < ActiveSupport::TestCase
  test "should not save car without model" do
    car = Car.new(registration_number: "1345", owner_id: 4)
    assert car.invalid?
    assert_not car.errors[:model].empty?
  end

  test "should not save car without registration number" do
    car = Car.new(model: "bmw", owner_id: 4)
    assert car.invalid?
    assert_not car.errors[:registration_number].empty?
  end

  test "should not save car without owner" do
    car = Car.new(registration_number: "1345", model: "bmw")
    assert car.invalid?
    assert_not car.errors[:owner].empty?
  end

end
