require 'test_helper'
require 'capybara/rails'

class RegistrationTest < ActionDispatch::IntegrationTest
  def setup
    visit '/register' 
      fill_in("First name", with: "John")
      fill_in("Last name", with: "Smith")
      fill_in("Email", with: "johnsmith@gmail.com")
      fill_in("Password", with: "abc123")
      fill_in("Password confirmation", with: "abc123")
  end

  test "user can't register if the password and password confirmation don't match" do
    fill_in("Password confirmation", with: "abcabc")
    click_button("Create Person")

    assert_equal accounts_url, current_url
    assert has_content? "Something went wrong, please try again."
  end

  test "user can register without last name" do
    fill_in("Last name", with: '')
    click_button("Create Person")
 
    assert has_content? "Your account has been created."
  end

end
