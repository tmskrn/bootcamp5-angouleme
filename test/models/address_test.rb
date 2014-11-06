require 'test_helper'

class AddressTest < ActiveSupport::TestCase
   test "should not save address without city" do
    address = Address.new(street: "Zielona", zip_code: "32-440")
    assert address.invalid?
   end

   test "should not save address without street" do
    address = Address.new(city: "Sułkowice", zip_code: "32-440")
    assert address.invalid?
   end

   test "should not save address without zip code" do
    address = Address.new(city: "Sułkowice", street: "Zielona")
    assert address.invalid?
   end

   test "should not save address when zip code has wrong format" do
    address = Address.new(city: "Sułkowice", street: "Zielona", zip_code: "223")
    assert address.invalid? 
   end
end
