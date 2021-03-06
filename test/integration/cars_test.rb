require 'test_helper'
require 'capybara/rails'

class CarsTest < ActionDispatch::IntegrationTest

  def setup
    visit '/session/new'
    fill_in("email", with: "mmgumularz@gmail.com")
    fill_in("password", with: "abc123")
    click_button('Sign in')
  end

  test "user displays list of their cars" do
    visit cars_path
    assert has_content? "Here are all your cars" 
    assert has_content? "yaris"
  end

  test "user creates new car" do
    visit '/cars'
    click_link 'add new car'
    fill_in("Model", with: "some model")
    fill_in("Registration number", with: "123456a")
    click_button('go')
    assert_equal current_url, car_url(Car.last)
    assert has_content? "some model"
  end

  test "user edits one of their cars" do
    visit '/cars'
    first(:link, "edit").click
    fill_in("Model", with: "fiat uno")
    click_button('go')
    assert has_content? "Car was succesfully updated."
    assert has_content? "fiat uno"
    assert has_no_content? "bmw"
  end

  test "user displays one of their cars" do
    visit '/cars'
    first(:link, "show").click
    assert has_content? "Car details"
    assert has_content? "yaris" 
  end

  test "user deletes one of their cars" do
    visit '/cars'
    first(:link, "delete").click
    assert_equal current_path, '/cars'
    assert has_no_content? 'yaris' 
  end
  
end
