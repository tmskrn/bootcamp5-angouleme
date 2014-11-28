require 'test_helper'
require 'capybara/rails'

class LoginTest < ActionDispatch::IntegrationTest
  def login
    fill_in('email', with: "mmgumularz@gmail.com")
    fill_in('password', with: "abc123")
    click_button('Sign in')
  end

  test 'user successfully logs in' do
    visit '/login'
    login
    assert has_content?("Magdalena")
  end

  test 'user gets redirected to root page after loging in straight from login page' do
    visit '/login'
    login
    assert_equal root_url, current_url
  end

  test 'user gets forced to log in and gets redirected to previous location after' do
    visit '/cars'
    assert_equal current_url, new_session_url
    login
    assert_equal cars_url, current_url
  end

end
